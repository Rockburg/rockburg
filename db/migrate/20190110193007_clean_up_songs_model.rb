class CleanUpSongsModel < ActiveRecord::Migration[5.2]
  def change
    remove_column :songs, :streams
  end
end
