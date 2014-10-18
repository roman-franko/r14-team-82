class RemoveTextFromRequests < ActiveRecord::Migration
  def change
    remove_column :requests, :text
  end
end
