require 'spec_helper'

describe EventsController do
  describe '#show' do
    render_views
    let(:event) { create :event }

    it 'assigns event' do
      get :show, id: event
      assigns(:event).should eq event
    end

    it 'assigns new client' do
      get :show, id: event
      assigns(:client).class.should eq Client
      assigns(:client).new_record?.should be_true
    end

    it 'responds 200' do
      get :show, id: event
      response.code.should eq '200'
    end
  end
end
