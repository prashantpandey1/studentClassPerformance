# frozen_string_literal: true

# Question Model
class Question < ApplicationRecord
  has_one :response, dependent: :destroy
end
