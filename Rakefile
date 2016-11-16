# frozen_string_literal: true
require './app'

task default: 'notify:slack'

namespace 'notify' do
  task :slack do
    notify_on_slack
  end
end
