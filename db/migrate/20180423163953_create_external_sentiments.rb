class CreateExternalSentiments < ActiveRecord::Migration[5.2]
  def change
    create_table :external_sentiments do |t|
      t.string :source
      t.jsonb :content
      t.timestamps null: false
    end
  end
end
