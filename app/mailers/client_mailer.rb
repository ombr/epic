class ClientMailer < ActionMailer::Base
  default from: 'contact@studiocuicui.fr'
  def send_event_link(client, event)
    @client = client
    @event = event
    mail to: client.email, subject: "Photos Studio Cui Cui : #{event.name}"
  end
end
