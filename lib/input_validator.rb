# frozen_string_literal: true

class InputValidator
  attr_reader :filename, :matching_type

  def self.call!(filename, matching_type)
    new(filename, matching_type).call!
  end

  def initialize(filename, matching_type)
    @filename = filename
    @matching_type = matching_type
  end

  private_class_method :new

  def call!
    exit_with_help if !filename && !matching_type

    errors = []
    errors << "\"#{filename}\" is not a valid file" unless File.file?(filename)
    unless Grouping::MATCHING_TYPES.include?(matching_type.to_sym)
      errors << "\"#{matching_type}\" is not a valid matching type"
    end

    exit_with_help(errors) if errors.any?
  end

  def exit_with_help(errors = [])
    message = "#{error_message(errors)}\n\n#{help}"

    puts message.strip
    exit
  end

  def error_message(errors)
    return "" if errors.empty?

    message = ["Errors:"]
    errors.each do |e|
      message << "  #{e}"
    end

    message.join("\n")
  end

  def help
    <<~HELP
      usage: grouping <input_file> <matching_type>

      grouping identifies rows in a CSV file that may represent the same person based on a provided Matching Type.

      input_file:       must be a valid CSV file
      matching_type:    #{Grouping::MATCHING_TYPES.join("|")}
    HELP
  end
end
