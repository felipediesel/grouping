# frozen_string_literal: true

require "csv"

class ContactParser
  ATTR_MAPPING = {
    FirstName: :first_name,
    LastName: :last_name,
    Phone: :phone,
    Email: :email,
    Zip: :zip
  }.freeze

  attr_reader :filename

  def initialize(filename)
    @filename = filename
  end

  def data
    @data ||= csv_content[1..-1].map do |row|
      row_to_object(row)
    end
  end

  def header
    csv_content[0]
  end

  private

  def csv_content
    @csv_content ||= CSV.read(filename)
  end

  def row_to_object(row)
    row.to_enum(:each_with_index).map do |value, i|
      [ATTR_MAPPING[header[i].to_sym], value]
    end.to_h
  end
end
