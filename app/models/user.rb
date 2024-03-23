# frozen_string_literal: true

# User model which present user in db
class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } # URI in the standard ruby library
  validates :json_web_token, presence: true

  has_many :messages
end
