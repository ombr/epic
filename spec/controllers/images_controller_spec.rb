require 'spec_helper'

describe ImagesController do
  describe '#show' do
    it 'return 200 if image exits' do
      image = create :image
      get :show, {id: image.md5}
      response.code. should == '200'
    end
  end

end
