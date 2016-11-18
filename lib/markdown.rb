# frozen_string_literal: true

# Markdown utility methods
module Markdown
  def self.to_list(array)
    array.map { |element| ('- ' + element) }
  end
end
