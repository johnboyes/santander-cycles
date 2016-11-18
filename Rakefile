# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slack_notification'
require 'bikepoints_markdown_generator'

task default: 'notify:slack'

desc 'Notify Santander Cycles availability on Slack'
namespace 'notify' do
  task :slack do
    notify_on_slack
  end
end

desc 'Generate "BIKEPOINTS.md" with list of all Santander Cycles bikepoint names'
task :generate_bikepoints_markdown do |task_name|
  next puts missing_environment_variable_message task_name unless ENV['BIKEPOINT_API_URL']
  BikepointsMarkdown.generate
end

def missing_environment_variable_message(task_name)
  <<~HEREDOC
    you must set the 'BIKEPOINT_API_URL' environment variable, either by running:
      `rake #{task_name} BIKEPOINT_API_URL=<put_the_url_here>`
    or:
      `foreman run rake #{task_name}`
  HEREDOC
end
