class DropTableSingleAlbum < ActiveRecord::Migration[5.2]
  def change
    drop_table :single_albums
  end
end
