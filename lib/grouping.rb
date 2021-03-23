# frozen_string_literal: true

class Grouping
  MATCHING_TYPES = %i(email phone both)

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

    puts filename
    puts matching_type
  end

  def filename
    argv[0]
  end

  def matching_type
    argv[1]
  end
end
