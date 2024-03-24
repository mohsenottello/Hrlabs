# frozen_string_literal: true

# Daily background job which run two other jobs for reporting new messages and users
class Daily::ReportNewMessagesAndUsersJob < ApplicationJob
  MODELS = [User, Message].freeze
  queue_as :default

  def perform
    now = Time.zone.now
    date = now.to_date

    date = Date.yesterday unless date.end_of_day - now < 60.seconds

    MODELS.each do |model|
      Report::NewMessagesAndUsersJob.perform_in(1.minute, model, date)
    end
  end
end
