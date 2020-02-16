class RemoveMeritFieldsFromManagers < ActiveRecord::Migration[6.0]
  def self.up
    remove_column :managers, :sash_id
    remove_column :managers, :level
  end
end
