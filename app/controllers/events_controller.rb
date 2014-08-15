# EventsController
class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    @client = Client.new
  end
end
