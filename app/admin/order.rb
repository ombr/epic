ActiveAdmin.register Order do
  config.sort_order = 'created_at DESC'
  index do
    selectable_column
    column :id
    column :created_at
    column :client
    column :image do |order|
      link_to [:admin, order.image] do
        image_tag(order.image.url(:icon))
      end
    end
    column :download do |order|
      link_to order.image.original.url(query: {'response-content-disposition' => 'attachment'}), target: '_blank' do
        'download'
      end
    end
    column :event
    actions
  end
  show do
    attributes_table do
      row :download do |order|
        link_to order.image.original.url(query: {'response-content-disposition' => 'attachment'}), target: '_blank' do
          'download'
        end
      end
      row :event
      row :client
    end
    active_admin_comments
  end

  # filter :client, collection: proc { Client.where(id: Order.pluck(:client_id)).map { |client| [client.email, client.id] } }
  filter :client, collection: proc{ Order.clients_collection }
  filter :event, collection: proc{ Order.events_collection }
end
