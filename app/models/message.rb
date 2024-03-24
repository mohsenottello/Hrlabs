# frozen_string_literal: true

# Message model which present messages from user
class Message < ApplicationRecord
  validates :title, presence: true

  belongs_to :user

  scope :search_by_keyword, ->(keyword) { where("messages.body ILIKE '%#{keyword}%' OR messages.title ILIKE '%#{keyword}%'") }
end
