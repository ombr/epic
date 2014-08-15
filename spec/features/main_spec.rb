require 'spec_helper'
require 'capybara/email/rspec'

describe 'Main features', :feature do
  it 'client can register on an event and order a picture' do
    event = create :event
    create :image, events: [event]
    visit event_path(id: event)
    fill_in 'Email', with: 'luc@boissaye.fr'
    click_on 'Go'
    open_email('luc@boissaye.fr')
    current_email.click_link event.name
  end
end
