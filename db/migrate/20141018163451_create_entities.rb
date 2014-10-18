class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.integer :request_id
      t.date :start_date
      t.date :end_date
      t.string :headline
      t.text :text
      t.string :media

      t.timestamps
    end
  end
end
