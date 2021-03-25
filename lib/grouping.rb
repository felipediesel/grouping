# frozen_string_literal: true

class Grouping
  MATCHING_TYPES = %i[email phone both].freeze

  attr_reader :argv

  def self.start(argv = ARGV)
    new(argv).start
  end

  def initialize(argv)
    @argv = argv
  end

  private_class_method :new

  def start
    InputValidator.call!(filename, matching_type)

    contacts = ContactParser.new(filename)
    result = Matcher.call(contacts.data, matching_type)
    grouped_header = ["UUID", *contacts.header]
    CsvGenerator.call(result, grouped_header, grouped_filename)

    puts "#{grouped_filename} created"
  end

  def filename
    argv[0]
  end

  def grouped_filename
    @grouped_filename ||= FilenameGenerator.call(filename)
  end

  def matching_type
    argv[1]&.to_sym
  end
end
