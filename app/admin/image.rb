ActiveAdmin.register Image do
  controller do
    defaults finder: :find_by_md5
  end

  index do
    selectable_column
    column :taken_at
    column :image do |image|
      image_tag(image.image.url(:icon))
    end
    actions
  end
  show do
    attributes_table do
      row :image do |image|
        image_tag(image.image.url(:social)).html_safe
      end
      row :events do |image|
        image.events.map do |event|
          link_to [:admin, event] do
            event.name
          end
        end.join(' ').html_safe
      end
    end
    active_admin_comments
  end

  filter :name
end
