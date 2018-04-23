class AddLastSeenAtToManagers < ActiveRecord::Migration[5.2]
  def change
    add_column :managers, :last_seen_at, :datetime
  end
end
