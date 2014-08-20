ActiveAdmin.register Event do
  permit_params :download, :order

  index do
    selectable_column
    column :name
    column :download
    column :order
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :name
      row :link do |event|
        link_to event do
          event_url event
        end
      end
      row :images do |event|
        event.images.map do |image|
          link_to [:admin, image] do
            image_tag(image.image.url(:icon))
          end
        end.join('').html_safe
      end

      row :clients do |event|
        event.clients.map do |client|
          link_to [:admin, client] do
            client.email
          end
        end.join('').html_safe
      end
    end
    active_admin_comments
  end
  form do |f|
    f.inputs 'Event' do
      f.input :download
      f.input :order
    end
    f.actions
  end

  filter :name
end
