# frozen_string_literal: true

# Question Model
class Question < ApplicationRecord
  has_one :response, dependent: :destroy
  has_one :quiz, through: :response
end
