require 'spec_helper'

describe ClientsController do
  let(:event) { create :event }

  describe '#new' do
    render_views
    it 'assigns event' do
      get :new, event_id: event
      assigns(:event).should eq event
    end

    it 'assigns new client' do
      get :new, event_id: event
      assigns(:client).class.should eq Client
      assigns(:client).new_record?.should be_true
    end

    it 'responds 200' do
      get :new, event_id: event
      response.code.should eq '200'
    end
  end

  describe '#create' do
    it 'renders new when email is invalid' do
      post :create, event_id: event, client: { email: '' }
      response.should render_template 'new'
    end

    it 'create a client' do
      expect do
        post :create, event_id: event, client: { email: 'luc@boissaye.fr' }
      end.to change { Client.count }.by(1)
    end

    it 'manage if email already exists' do
      client = create :client, email: 'luc@boissaye.fr'
      post :create, event_id: event, client: { email: 'luc@boissaye.fr' }
      client.events.should include(event)
    end

    it 'redirect and flash on success' do
      post :create, event_id: event, client: { email: 'luc@boissaye.fr' }
      response.should redirect_to new_event_client_path(event_id: event)
      flash[:success].should_not be_nil
    end

  end

end
