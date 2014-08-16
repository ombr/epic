require 'spec_helper'

describe OrdersController do
  let(:client) { create :client }
  let(:image) { create :image }
  let(:event) { create :event, images: [image], clients: [client] }

  describe '#create' do
    it 'creates an order' do
      expect do
        post :create, order: {
          event_id: event.id,
          client_id: client.id,
          image_id: image.id
        }
      end.to change { Order.count }.by(1)
    end

    it 'redirect to image' do
      post :create, order: {
        event_id: event.id,
        client_id: client.id,
        image_id: image.id
      }
      response.should redirect_to [client, event, image]
    end
  end

  describe '#destroy' do
    it 'redirect to image' do
      order = create :order, event: event, image: image, client: client
      delete :destroy, id: order, client_id: client
      response.should redirect_to [client, event, image]
    end

    it 'delete an order' do
      order = create :order, event: event, image: image, client: client
      expect do
        delete :destroy, id: order, client_id: client
      end.to change { Order.count }.by(-1)
    end
  end
end
