# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    title { 'test title' }
    body { 'test body' }
    user
  end
end
