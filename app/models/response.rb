# frozen_string_literal: true

# Response Model
class Response < ApplicationRecord
  belongs_to :quiz
  belongs_to :question
end
