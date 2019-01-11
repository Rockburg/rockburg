class CreateStreams < ActiveRecord::Migration[5.2]
  def change
    create_table :streams do |t|
      t.references :band, foreign_key: true
      t.references :release, foreign_key: true
      t.bigint :num_streams
      t.timestamps
    end
  end
end
