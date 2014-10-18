class RequestsEntity < ActiveRecord::Base
  belongs_to :request
  belongs_to :entity
end
