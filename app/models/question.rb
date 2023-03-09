# frozen_string_literal: true

# Question Model
class Question < ApplicationRecord
  has_many :responses, dependent: :destroy
end
