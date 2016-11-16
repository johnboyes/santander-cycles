# frozen_string_literal: true
require 'json'
require 'rest-client'
require './bikepoint'

def all_bikepoints
  JSON.parse(RestClient.get(ENV['BIKEPOINT_API_URL']))
end

def bikepoint(common_name)
  Bikepoint.new(all_bikepoints.find { |bikepoint| bikepoint['commonName'] == common_name })
end

def post_to_slack_webhook(url, attachments)
  RestClient.post url, { 'attachments' => attachments }.to_json, content_type: :json, accept: :json
end

def attachment(bikepoint_name)
  bikepoint = bikepoint(bikepoint_name)
  field_text = "#{bikepoint.bikes} bikes\n#{bikepoint.spaces} spaces"
  {
    'fallback' => "#{bikepoint.name}: #{bikepoint.bikes} bikes, #{bikepoint.spaces} spaces",
    'color' => 'good',
    'fields' => [{ 'title' => bikepoint.name, 'value' => field_text }]
  }
end

def notify_on_slack
  ENV['BIKEPOINT_COMMON_NAMES'].split(';').each do |bikepoint_name|
    post_to_slack_webhook(ENV['SLACK_WEBHOOK_URL'], [attachment(bikepoint_name)])
  end
end
