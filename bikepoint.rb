# frozen_string_literal: true
# A bike point with a rack of cycles for hire.
class Bikepoint
  def initialize(raw_json)
    @raw_json = raw_json
  end

  def additional_property(property)
    @raw_json['additionalProperties'].find { |p| p['key'] == property }['value']
  end

  def name
    @raw_json['commonName']
  end

  def spaces
    additional_property('NbEmptyDocks')
  end

  def bikes
    additional_property('NbBikes')
  end
end
