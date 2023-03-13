# frozen_string_literal: true

# StudentsPerformance
class StudentsPerformance
  include PerformanceAverage
  def initialize(quiz_type, page_num = 1)
    @page_num = page_num
    @quiz_type = quiz_type
  end

  def analyze
    users = User.page(@page_num)
    users = users.where(quizzes: { quiz_type: @quiz_type }) if @quiz_type.present?
    users.eager_load(:responses).collect do |user|
      responses = user.responses.to_a
      correct_responses = responses.count(&:correct?)
      {
        user_id: user.id,
        first_name: user.first_name,
        last_name: user.last_name,
        correct_avg_percentage: get_average(correct_responses, responses.length)
      }
    end
  end
end
