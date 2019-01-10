class CleanUpRecordings < ActiveRecord::Migration[5.2]
  def change
    add_reference :recordings, :song, foreign_key: true
    remove_column :recordings, :kind
    remove_column :recordings, :sales
    remove_column :recordings, :release_at
    remove_column :recordings, :name
  end
end
