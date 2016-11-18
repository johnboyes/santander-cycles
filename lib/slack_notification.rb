# frozen_string_literal: true
require 'rest_client'

# Able to notify availability on Slack; see https://api.slack.com/incoming-webhooks
module SlackNotifier
  def self.notify
    ENV['BIKEPOINT_COMMON_NAMES'].split(';').each do |bikepoint_name|
      Bikepoint.all[bikepoint_name].notify
    end
  end

  def attachment
    field_text = "#{bikes} bikes\n#{spaces} spaces"
    {
      'fallback' => "#{name}: #{bikes} bikes, #{spaces} spaces",
      'color' => 'good',
      'fields' => [{ 'title' => name, 'value' => field_text }]
    }
  end

  def notify
    RestClient.post_json ENV['SLACK_WEBHOOK_URL'], attachments: [attachment]
  end
end
