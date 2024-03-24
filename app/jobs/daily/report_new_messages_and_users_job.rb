# frozen_string_literal: true

require 'sidekiq'

# Daily background job which run two other jobs for reporting new messages and users
class Daily::ReportNewMessagesAndUsersJob
  include Sidekiq::Job
  MODELS = ['User', 'Message'].freeze
  queue_as :default

  def perform
    MODELS.each do |model|
      Report::NewMessagesAndUsersJob.perform_in(1.minute, model)
    end
  end
end
