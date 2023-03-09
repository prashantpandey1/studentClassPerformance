# frozen_string_literal: true

# Quiz Model
class Quiz < ApplicationRecord
  belongs_to :user
  has_many :responses, dependent: :destroy
end
