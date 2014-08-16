class CreateOrder < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.timestamps
      t.integer :client_id
      t.integer :event_id
      t.integer :image_id
    end
    add_index :orders, [:client_id, :event_id, :image_id], unique: true
  end
end
