# frozen_string_literal: true

# background job which import new models into csv file
class Report::NewMessagesAndUsersJob < ApplicationJob
  queue_as :default

  def perform(model, date)
    Importer::ModelsByDate.call(model: model, date: date)
  end
end
