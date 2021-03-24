# frozen_string_literal: true

require "csv"
require "securerandom"

class Matcher
  attr_reader :data, :type, :matches

  def self.call(data, type)
    new(data, type).call
  end

  def initialize(data, type)
    @data = data
    @type = type
    @matches = {}
  end

  private_class_method :new

  def call
    @data.collect do |row|
      row[:uuid] = uuid_for(row)
      row
    end
  end

  def uuid_for(row)
    value = value_for_type(row, type)
    return SecureRandom.uuid if !value || value == ""
    return @matches[value] if @matches[value]

    @matches[value] = SecureRandom.uuid
  end

  def value_for_type(row, type)
    if type == :both
      "#{row[:email]}#{row[:phone]}"
    else
      row[type]
    end
  end
end
