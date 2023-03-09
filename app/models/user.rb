# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  paginates_per 10
  has_many :quizzes, dependent: :destroy
  has_many :responses, through: :quizzes
end
