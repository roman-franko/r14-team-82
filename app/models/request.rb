require Rails.root.join('lib', 'wiki_parser')

class Request < ActiveRecord::Base
  has_many :requests_entities
  has_many :entities, through: :requests_entities

  validates :request_string, presence: true

  def self.create_with_entities!(params)
    request = Request.new params
    request.build_entities
    if request.entities.present?
      request
    else
      nil
    end
  end

  def build_entities
    w =  WikiParser.new
    entities_arr = request_string.split(',').map { |entity| entity.gsub(/(\A\s*)|(\s*\z)/, '') }
    entities_arr.each do |entity|
      w.load(entity)
      if w.valid?
        entities << Entity.create(start_date: w.start_date,
          end_date: w.end_date,
          headline: w.title,
          text: w.title, #w.html,
          media: w.url)
      end
    end
  end
end
