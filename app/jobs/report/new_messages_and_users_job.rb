# frozen_string_literal: true

require 'sidekiq'

# background job which import new models into csv file
class Report::NewMessagesAndUsersJob
  include Sidekiq::Job
  queue_as :default

  def perform(model)
    Importer::ModelsByDate.call(model: model, date: Date.yesterday)
  end
end
