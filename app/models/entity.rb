require 'wiki_parser'

class Entity < ActiveRecord::Base

  def load(keyword)
    w =  WikiParser.new
    w.load(keyword)
    self.start_date = w.start_date
    self.end_date = w.end_date
    self.headline = w.title
    #self.text = w.html
    self.media = w.url
    save
  end

end
