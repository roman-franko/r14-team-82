require Rails.root.join('lib', 'wiki_parser')

class Request < ActiveRecord::Base
  has_many :requests_entities
  has_many :entities, through: :requests_entities

  validates :request_string, presence: true

  def self.create_with_entities!(params)
    request = Request.create! params
    request.build_entities
    request
  end

  def build_entities
    entities_arr = request_string.split(',').map { |entity| entity.gsub(/(\A\s*)|(\s*\z)/, '') }
    entities_arr.each { |entity| entities << Entity.create(fetch_wiki_data entity) }
  end

  private

  def fetch_wiki_data(string)
    w =  WikiParser.new
    w.load(string)
    {
      start_date: w.start_date,
      end_date: w.end_date,
      headline: w.title,
      text: w.html,
      media: w.url
    }
  end

end
