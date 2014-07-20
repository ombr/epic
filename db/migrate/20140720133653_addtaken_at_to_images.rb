class AddtakenAtToImages < ActiveRecord::Migration
  def change
    add_column :images, :taken_at, :timestamp
  end
end
