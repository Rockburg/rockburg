class CreateJoinTableRecordingRelease < ActiveRecord::Migration[5.2]
  def change
    create_join_table :recordings, :releases do |t|
      t.index [:recording_id, :release_id]
    end
  end
end
