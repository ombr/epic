class ClientsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @client = Client.new
  end

  def create
    @event = Event.find(params[:event_id])
    @client = Client.find_or_create_by email: client_params[:email]
    @client.events << @event unless @client.events.include?(@event)
    if @client.save
      ClientMailer.send_event_link(@client, @event).deliver
      redirect_to new_event_client_path(event_id: @event), flash: { success: 'Email has been registerd' }
    else
      render :new
    end
  end

  private

  def client_params
    params.require(:client).permit(:email)
  end
end
