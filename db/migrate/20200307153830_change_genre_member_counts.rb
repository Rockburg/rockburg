class ChangeGenreMemberCounts < ActiveRecord::Migration[6.0]
  def change
    add_column :genres, :total_members, :integer
  end
end
