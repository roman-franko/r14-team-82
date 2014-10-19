require 'wikipedia'

# Usage:
# require 'wiki_parser'
# w =  WikiParser.new
# w.load('Java')
# w.start_date
# w.end_date
# w.title
# w.html

class WikiParser

  attr_reader :page

  def load(title)
    @page = Wikipedia.find title
    @start_date = nil
    @end_date = nil
  end

  def title
    @page.title
  end

  def url
    'http://en.wikipedia.org/wiki/'+@page.title.gsub(' ', '_')
  end

  def start_date
    @start_date ||= date 'BIRTH'
  end

  def end_date
    @end_date ||= date 'DEATH'
  end

  def html
    @wiki = WikiCloth::Parser.new({ data: @page.content })
    @wiki.to_html
  end

  def valid?
    start_date.present? || end_date.present?
  end

  private

  def date(event)
    s = @page.content
    return nil if s.nil?
    date_string = s[/(?<=DATE OF #{event}) *= *[-,\w ]+/]
    date = nil
    if date_string
      date_string = date_string[/(?<==) *[-,\w ]+/]
      date = Date.parse(date_string)
    else
      year_string = s[/year += (\{\{start date and age\|)?\d+/]
      if year_string
        year = year_string[/\d+/]
        date = Date.parse(year+'0701')
      end
    end
    date
  end

end

