# frozen_string_literal: true
require 'bikepoint'
require 'markdown'

# Generates BIKEPOINTS.md
module BikepointsMarkdown
  def self.generate
    File.open('BIKEPOINTS.md', 'w+') do |file|
      file.puts('# All Santander Cycles bikepoint names',
                'Copy all the names you wish to receive notifications for into a semi-colon
                separated list in the `BIKEPOINT_COMMON_NAMES` environment variable.',
                Markdown.to_list(Bikepoint.all_names).sort)
    end
  end
end
