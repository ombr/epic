class AddOrderToEvent < ActiveRecord::Migration
  def change
    add_column :events, :order, :boolean, default: false, nil: false
  end
end
