# frozen_string_literal: true

# For serialzing User model in controller
class UserSerializer < ActiveModel::Serializer
  attributes :email, :json_web_token
end
