class Request < ActiveRecord::Base
  has_many :entities, inverse_of: :request, dependent: :destroy

  validates :text, presence: true
end
