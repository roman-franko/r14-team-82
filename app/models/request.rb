class Request < ActiveRecord::Base
  has_many :entities, through: :requests_entities


  def self.find_entities(entities)
    Request.create
  end
end
