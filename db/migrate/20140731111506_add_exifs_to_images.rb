class AddExifsToImages < ActiveRecord::Migration
  def change
    add_column :images, :exifs, :hstore
  end
end
