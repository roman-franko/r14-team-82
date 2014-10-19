class RequestSerializer < ActiveModel::Serializer
  attributes :id

  self.root = false

  def with_entities
    data = []
    object.entities.each do |entity|
      data << {
        "startDate" => entity.start_date.to_s.gsub('-', ','),
        "endDate" => entity.end_date.to_s.gsub('-', ','),
        "headline" => entity.headline,
        "text" => entity.text,
        "asset" => {
          "media" => entity.media,
          "credit" => "",
          "caption" => ""
        }
      }
    end
    data
  end

  def attributes
    attrs = super
    attrs[:entities] = object.entities.map(&:headline).join(', ')
    attrs
  end

  def as_json(options={})
    case scope
    when 'entities'
      with_entities.to_json
    else
      super
    end
  end
end
