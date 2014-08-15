class CreateClientsEvents < ActiveRecord::Migration
  def change
    create_table :clients_events do |t|
      t.integer :client_id
      t.integer :event_id
    end
    add_index :clients_events, [:event_id, :client_id]
  end
end
