# frozen_string_literal: true
require 'bikepoint'

def to_markdown_list(array)
  array.map { |e| ('- ' + e) }
end

def generate_bikepoints_markdown
  File.open('BIKEPOINTS.md', 'w+') do |f|
    f.puts('# All Santander Cycles bikepoint names')
    f.puts('Copy all the names you wish to receive notifications for into a semi-colon separated
            list in the `BIKEPOINT_COMMON_NAMES` environment variable.')
    f.puts(to_markdown_list(Bikepoint.all_names).sort)
  end
end
