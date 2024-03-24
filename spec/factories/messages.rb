# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    sequence :title do |n|
      "title#{n} test"
    end

    sequence :body do |n|
      "body#{n} test"
    end

    user
  end
end
