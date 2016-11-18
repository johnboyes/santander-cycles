# frozen_string_literal: true
require 'json'
require 'rest-client'
require 'slack_notifier'

# A bike point with a rack of cycles for hire.
class Bikepoint
  include SlackNotifier

  def self.all
    @bikepoints ||= all_json.map { |json| [json['commonName'], Bikepoint.new(json)] }.to_h
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
    @raw_json['additionalProperties'].find { |prop| prop['key'] == property }['value']
  end
end
