class CreateRequestsEntities < ActiveRecord::Migration
  def change
    create_table :requests_entities do |t|
      t.integer :request_id
      t.integer :entity_id

      t.timestamps
    end
  end
end
