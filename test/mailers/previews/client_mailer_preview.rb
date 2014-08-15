# ClientMailerPreview
class ClientMailerPreview < ActionMailer::Preview
  def send_event_link
    ClientMailer.send_event_link(Client.last, Event.last)
  end
end
