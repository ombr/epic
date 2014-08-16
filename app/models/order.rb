# Order
class Order < ActiveRecord::Base
  belongs_to :client
  belongs_to :image
  belongs_to :event

  def self.clients_collection
    Client.where(id: Order.pluck(:client_id)).map do |client|
      [client.email, client.id]
    end
  end

  def self.events_collection
    Event.where(id: Order.pluck(:event_id)).map do |event|
      [event.name, event.id]
    end
  end
end
