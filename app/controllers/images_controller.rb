# ImagesController
class ImagesController < ApplicationController

  skip_before_action  :verify_authenticity_token, only: [:create]

  def show
    @image = Image.find_by_md5(params[:id])
    fail ActiveRecord::RecordNotFound if @image.nil?
    render nothing: true
  end

  def create
    @image = Image.delay.create_from_path params[:path]
    render nothing: true
  end

  def index
    @images = Image.all
  end
end
