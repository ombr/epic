class AddDownloadToEvent < ActiveRecord::Migration
  def change
    add_column :events, :download, :boolean, default: false, nil: false
  end
end
