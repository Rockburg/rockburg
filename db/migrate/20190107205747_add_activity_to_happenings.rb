class AddActivityToHappenings < ActiveRecord::Migration[5.2]
  def change
    add_reference :happenings, :activity, foreign_key: true
  end
end
