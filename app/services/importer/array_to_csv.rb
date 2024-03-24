# frozen_string_literal: true

require 'csv'

# For converting array to csv
class Importer::ArrayToCsv
  def self.call(array:, file_name:)
    new(array: array, file_name: file_name).call
  end

  def initialize(array:, file_name:)
    raise ArgumentError, "array shoud be Array, not #{array.class}" unless array.is_a?(Array)
    raise ArgumentError, "file_name shoud be String, not #{file_name.class}" unless file_name.is_a?(String)

    @array = array
    @file_name = file_name
  end

  def call
    FileUtils.mkdir_p('tmp')

    CSV.open("tmp/#{@file_name}.csv", 'wb') do |csv|
      keys = @array.first.keys
      # header_row
      csv << keys

      @array.each do |hash|
        csv << hash.values_at(*keys)
      end
    end
  end
end
