ActiveAdmin.register Client do
  index do
    selectable_column
    column :id
    column :email
    column :orders do |client|
      link_to [:admin, :orders, {q: { client_id_eq: client.id } }] do
        client.orders.count.to_s
      end
    end
    actions
  end
  show do
    attributes_table do
      row :events do |client|
        client.events.map do |event|
          link_to [:admin, event] do
            event.name
          end
        end.join(' ').html_safe
      end

      row :orders do |client|
        link_to [:admin, :orders, {q: { client_id_eq: client.id } }] do
          "Go to orders (#{client.orders.count})"
        end
      end

      row :events_links do |client|
        client.events.map do |event|
          link_to client_event_images_url(client_id: client, event_id: event) do
            "#{event.name} (#{client_event_images_url(client_id: client, event_id: event)})"
          end
        end.join(' ').html_safe
      end
    end
    active_admin_comments
  end

  filter :name
end
