class CreateReleases < ActiveRecord::Migration[5.2]
  def change
    create_table :releases do |t|
      t.references :band
      t.string :name
      t.string :kind

      t.timestamps
    end
  end
end
