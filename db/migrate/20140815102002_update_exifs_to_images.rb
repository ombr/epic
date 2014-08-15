class UpdateExifsToImages < ActiveRecord::Migration
  def change
    remove_column :images, :exifs
    add_column :images, :exifs, :json
  end
end
