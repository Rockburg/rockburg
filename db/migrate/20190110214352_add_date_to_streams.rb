class AddDateToStreams < ActiveRecord::Migration[5.2]
  def change
    add_column :streams, :for_date, :date
  end
end
