# frozen_string_literal: true

# Find new modles by date and import them to csv file
class Importer::ModelsByDate
  def self.call(model:, date:)
    new(model: model, date: date).call
  end

  def initialize(model:, date:)
    raise ArgumentError, "model shoud be String, not #{model.class}" unless model.is_a?(String)
    raise ArgumentError, "date shoud be Date, not #{date.class}" unless date.is_a?(Date)

    @model = model
    @date = date
  end

  def call
    @model = @model.constantize
    array = @model.search_by_day(@date).as_json

    return if array.blank?

    Importer::ArrayToCsv.call(
      array: User.search_by_day(@date).as_json,
      file_name: "#{@model.name.pluralize} - #{@date}"
    )
  end
end
