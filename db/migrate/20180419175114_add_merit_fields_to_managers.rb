class AddMeritFieldsToManagers < ActiveRecord::Migration[5.2]
  def change
    add_column :managers, :sash_id, :integer
    add_column :managers, :level,   :integer, :default => 0
  end
end
