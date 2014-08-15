class CreateEventsImages < ActiveRecord::Migration
  def change
    create_table :events_images do |t|
      t.integer :event_id
      t.integer :image_id
    end
    add_index :events_images, [:event_id, :image_id]
  end
end
