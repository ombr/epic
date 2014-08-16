# OrdersController
class OrdersController < ApplicationController
  def create
    @order = Order.new order_params
    fail 'Client not registred' unless @order.client.events.include? @order.event
    fail 'Image not in event' unless @order.image.events.include? @order.event
    @order.save!
    redirect_to [@order.client, @order.event, @order.image]
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy if params[:client_id] == @order.client.slug
    redirect_to [@order.client, @order.event, @order.image]
  end

  def order_params
    params.require(:order).permit(:client_id, :image_id, :event_id)
  end
end
