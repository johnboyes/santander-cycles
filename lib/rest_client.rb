# frozen_string_literal: true
require 'json'
require 'rest-client'

# add method to RestClient class
module RestClient
  def self.post_json(url, body)
    RestClient.post(url, body.to_json, content_type: :json, accept: :json)
  end
end
