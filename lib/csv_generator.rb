# frozen_string_literal: true

require "csv"

class CsvGenerator
  ATTRIBUTES = %i[uuid first_name last_name phone email zip].freeze

  attr_reader :data, :headers, :filename

  def self.call(data, headers, filename)
    new(data, headers, filename).call
  end

  def initialize(data, headers, filename)
    @data = data
    @headers = headers
    @filename = filename
  end

  private_class_method :new

  def call
    content = CSV.generate(headers: true) do |csv|
      csv << headers

      data.each do |row|
        csv << ATTRIBUTES.map { |attr| row[attr] }
      end
    end

    File.write(filename, content)
  end
end
