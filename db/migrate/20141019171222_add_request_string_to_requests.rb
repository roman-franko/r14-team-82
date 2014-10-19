class AddRequestStringToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :request_string, :string
  end
end
