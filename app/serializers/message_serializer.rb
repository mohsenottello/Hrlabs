# frozen_string_literal: true

# For serialzing User model in controller
class MessageSerializer < ActiveModel::Serializer
  attributes :id, :title, :body
end
