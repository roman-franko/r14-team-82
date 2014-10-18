class RemoveRequestIdFromEntities < ActiveRecord::Migration
  def change
    remove_column :entities, :request_id
  end
end
