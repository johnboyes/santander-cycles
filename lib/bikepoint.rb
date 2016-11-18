# frozen_string_literal: true
require 'json'
require 'rest-client'

# A bike point with a rack of cycles for hire.
class Bikepoint
  def self.all
    @bikepoints ||= all_json.map { |j| [j['commonName'], Bikepoint.new(j)] }.to_h
  end

  def self.all_json
    JSON.parse(RestClient.get(ENV['BIKEPOINT_API_URL']))
  end

  def self.all_names
    all.keys
  end

  attr_reader :name, :bikes, :spaces

  def initialize(raw_json)
    @raw_json = raw_json
    @name = @raw_json['commonName']
    @bikes = additional_property('NbBikes')
    @spaces = additional_property('NbEmptyDocks')
  end

  def additional_property(property)
    @raw_json['additionalProperties'].find { |p| p['key'] == property }['value']
  end
end
