# frozen_string_literal: true
require 'dotenv'
Dotenv.load('spec/env/test.env')
require 'rspec'
require 'webmock/rspec'
require 'rake'

def stub_slack_request(bikepoint_name, bikes, spaces)
  stub_request(:post, ENV['SLACK_WEBHOOK_URL'])
    .with(body:
          { attachments:
            [{
              'fallback' => "#{bikepoint_name}: #{bikes} bikes, #{spaces} spaces",
              'color' => 'good',
              'fields' =>
                [{ 'title' => bikepoint_name, 'value' => "#{bikes} bikes\n#{spaces} spaces" }]
            }] })
end

RSpec.configure do |config|
  config.before(:suite) do
    Rake.application.init
    Rake.application.load_rakefile
  end
end
