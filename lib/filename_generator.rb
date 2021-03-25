# frozen_string_literal: true

class FilenameGenerator
  attr_reader :grouped_filename, :counter

  def self.call(original_filename)
    new(original_filename).call
  end

  def initialize(original_filename)
    arr = original_filename.split(".")

    @grouped_filename = [arr[0..-2], "grouped", arr[-1]].join(".")
    @counter = 0
  end

  private_class_method :new

  def call
    filename = counter.zero? ? grouped_filename : next_filename

    if File.exist?(filename)
      @counter += 1
      call
    else
      filename
    end
  end

  def next_filename
    arr = grouped_filename.split(".")
    [arr[0..-2], counter, arr[-1]].join(".")
  end
end
