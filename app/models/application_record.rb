# frozen_string_literal: true

# Sharing method between models
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
