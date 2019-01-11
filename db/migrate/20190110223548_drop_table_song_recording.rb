class DropTableSongRecording < ActiveRecord::Migration[5.2]
  def change
    drop_table :song_recordings
  end
end
