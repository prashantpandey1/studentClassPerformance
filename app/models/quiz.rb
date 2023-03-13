# frozen_string_literal: true

# Quiz Model
class Quiz < ApplicationRecord
  belongs_to :user
  has_many :responses, dependent: :destroy

  def practice?
    quiz_type == 'practice'
  end

  def test?
    quiz_type == 'test'
  end
end
