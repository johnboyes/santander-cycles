# frozen_string_literal: true
require 'json'
require 'rest-client'

def all_bikepoints
  JSON.parse(RestClient.get(ENV['BIKEPOINT_API_URL']))
end

def bikepoint(common_name)
  all_bikepoints.find { |bikepoint| bikepoint['commonName'] == common_name }
end

def bikes(bikepoint)
  additional_property(bikepoint, 'NbBikes')
end

def spaces(bikepoint)
  additional_property(bikepoint, 'NbEmptyDocks')
end

def additional_property(bikepoint, property)
  bikepoint['additionalProperties'].find { |p| p['key'] == property }['value']
end

def post_to_slack_webhook(url, attachments)
  RestClient.post url, { 'attachments' => attachments }.to_json, content_type: :json, accept: :json
end

def attachment(bikepoint_name)
  bikepoint = bikepoint(bikepoint_name)
  field_text = "#{bikes(bikepoint)} bikes\n#{spaces(bikepoint)} spaces"
  {
    'fallback' => "#{bikepoint_name}: #{bikes(bikepoint)} bikes, #{spaces(bikepoint)} spaces",
    'color' => 'good',
    'fields' => [{ 'title' => bikepoint_name, 'value' => field_text }]
  }
end

def notify_on_slack
  ENV['BIKEPOINT_COMMON_NAMES'].split(';').each do |bikepoint_name|
    post_to_slack_webhook(ENV['SLACK_WEBHOOK_URL'], [attachment(bikepoint_name)])
  end
end
