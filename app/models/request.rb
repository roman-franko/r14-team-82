class Request < ActiveRecord::Base
  has_many :entities, through: :requests_entities

  validates :text, presence: true
end
