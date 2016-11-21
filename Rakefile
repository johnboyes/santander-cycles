# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'airbrake'
require 'bikepoint'
require 'markdown'

task default: 'notify:slack'

desc 'Notify Santander Cycles availability on Slack'
namespace 'notify' do
  task :slack do
    SlackNotifier.notify
  end
end

Airbrake.configure do |c|
  c.project_id = 133_461
  c.project_key = '47baf0b45c8229718715b07edee4b9e8'
end

desc 'Generate "BIKEPOINTS.md" with list of all Santander Cycles bikepoint names'
task :generate_bikepoints_markdown do |task_name|
  next puts missing_environment_variable_message task_name unless ENV['BIKEPOINT_API_URL']
  Markdown::Bikepoints.generate
end

def missing_environment_variable_message(task_name)
  <<~HEREDOC
    you must set the 'BIKEPOINT_API_URL' environment variable, either by running:
      `rake #{task_name} BIKEPOINT_API_URL=<put_the_url_here>`
    or:
      `foreman run rake #{task_name}`
  HEREDOC
end
