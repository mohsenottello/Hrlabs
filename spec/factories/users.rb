# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "email#{n}@factory.com"
    end

    json_web_token { 'test' }
  end
end
