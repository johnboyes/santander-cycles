# frozen_string_literal: true
# See https://api.slack.com/incoming-webhooks
require 'json'
require 'rest-client'
require 'bikepoint'

def post_to_slack_webhook(url, bikepoint)
  attachments = [attachment(bikepoint)]
  RestClient.post url, { 'attachments' => attachments }.to_json, content_type: :json, accept: :json
end

def attachment(bikepoint)
  field_text = "#{bikepoint.bikes} bikes\n#{bikepoint.spaces} spaces"
  {
    'fallback' => "#{bikepoint.name}: #{bikepoint.bikes} bikes, #{bikepoint.spaces} spaces",
    'color' => 'good',
    'fields' => [{ 'title' => bikepoint.name, 'value' => field_text }]
  }
end

def notify_on_slack
  ENV['BIKEPOINT_COMMON_NAMES'].split(';').each do |bikepoint_name|
    post_to_slack_webhook(ENV['SLACK_WEBHOOK_URL'], Bikepoint.all[bikepoint_name])
  end
end
