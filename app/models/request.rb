require Rails.root.join('lib', 'wiki_parser')

class Request < ActiveRecord::Base
  has_many :requests_entities
  has_many :entities, through: :requests_entities

  validates :request_string, presence: true

  def self.create_with_entities!(params)
    request = Request.create! params
    request.build_entities
    if request.entities.present?
      request
    else
      nil
    end
  end

  def build_entities
    entities_arr = request_string.split(',').map { |entity| entity.gsub(/(\A\s*)|(\s*\z)/, '') }
    entities_arr.each do |entity_name|
      unless entity = Entity.find_by_headline(entity_name)
        if wiki_data = fetch_wiki_data(entity_name)
          entity = Entity.create(wiki_data)
        end
      end
      entities << entity if entity
    end
  end

  private

  def fetch_wiki_data(entity_name)
    w =  WikiParser.new
    w.load(entity_name)
    if w.valid?
      {
        start_date: w.start_date,
        end_date: w.end_date,
        headline: entity_name,
        text: w.title, #w.html,
        media: w.url
      }
    else
      nil
    end
  end
end
