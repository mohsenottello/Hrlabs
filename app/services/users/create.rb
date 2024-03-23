# frozen_string_literal: true

# Create user
class Users::Create
  def self.call(email)
    new(email).call
  end

  def initialize(email)
    raise ArgumentError, "email shoud be string, not #{email.class}" unless email.is_a?(String)

    @email = email
  end

  def call
    user = User.new(email: @email)

    user.json_web_token = generate_token
    user.save!

    user
  end

  def generate_token
    JWT.encode hash, Rails.application.credentials.dig(:user, :token), 'HS256'
  end

  def hash
    { email: @email }
  end
end
