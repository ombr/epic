# ImagesController
class ImagesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def new
    @image = Image.new
    @uploader = @image.original
    respond_to do |format|
      format.html do
        @uploader.success_action_redirect = add_images_url
      end
      format.json do
        @uploader.use_action_status = true
        @uploader.success_action_status = '201'
        render json: {
          utf8: '✓',
          key: @uploader.key,
          AWSAccessKeyId: @uploader.aws_access_key_id,
          acl: @uploader.acl,
          policy: @uploader.policy,
          signature: @uploader.signature,
          success_action_status: '201'
        }
      end
    end
  end

  def add
    @image = Image.new
    @uploader = @image.original
    @uploader.key = params[:key]
    if @image.save
      redirect_to images_path
    else
      redirect_to new_image_path
    end
  end

  def show
    if params[:client_id]
      @client = Client.find(params[:client_id])
      @event = @client.events.find(params[:event_id])
      @image = @event.images.find_by_md5(params[:id])
      @next = @image.next(@event)
      @previous = @image.previous(@event)
      @order = @image.orders.where(client_id: @client).first
      @order ||= Order.new client: @client, event: @event, image: @image
    else
      @image = Image.find_by_md5(params[:id])
      @image = Image.find(
        Image.where('image IS NOT NULL').pluck(:id).sample
      ) if params[:id] == 'random'
    end
    render nothing: true, status: :not_found if @image.nil?
  end

  def create
    @image = Image.new image_params
    @image[:original] = image_params[:original]
    @image.save!(run_callbacks: false)
    Resque.enqueue ImageConversion, @image.id
    render nothing: true
  end

  def index
    @client = Client.find(params[:client_id])
    @event = @client.events.find(params[:event_id])
    @images = @event.images.where('image IS NOT NULL').order(:taken_at)
  end

  def image_params
    params.require(:image).permit(:md5,
                                  :original)
  end
end
