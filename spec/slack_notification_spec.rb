# frozen_string_literal: true
require 'spec_helper'

RSpec.describe 'notifies bike availability on Slack' do
  before(:all) do
    @stubs =
      [
        stub_request(:get, 'https://api.tfl.gov.uk/bikepoint')
          .to_return(body: File.read('spec/examples/bikepoints.json')),
        stub_slack_request('River Street , Clerkenwell', 10, 9),
        stub_slack_request('Phillimore Gardens, Kensington', 12, 24)
      ]
  end
  it 'notifies bike availability on Slack' do
    Rake::Task['notify:slack'].invoke
    @stubs.each { |stub| assert_requested(stub) }
  end
end
