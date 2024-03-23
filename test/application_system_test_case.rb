# frozen_string_literal: true

require 'test_helper'

# For testing front part with selenuim
class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
end
