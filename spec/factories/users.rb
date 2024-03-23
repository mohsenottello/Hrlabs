# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end

  factory :user do
    email { 'test@gmail.com' }
    json_web_token { 'test' }
  end
end
