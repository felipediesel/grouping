# frozen_string_literal: true

class Grouping
  class Error < StandardError; end
  # Your code goes here...

  def self.start
    self.new.start
  end

  def initialize
  end

  def start
    puts 'start'
  end
end
