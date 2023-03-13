# frozen_string_literal: true

# A Service object that represents the performance of students based on quiz responses.
class StudentsPerformance
  include PerformanceAverage
  def initialize(quiz_type, page_num = 1)
    @page_num = page_num
    @quiz_type = quiz_type
  end

  def analyze
    users = User.eager_load(:responses).where(quizzes: { completed: 1 }).page(@page_num)
    users = users.where(quizzes: { quiz_type: @quiz_type }) if @quiz_type.present?
    users.collect do |user|
      responses = user.responses.to_a
      correct_responses = responses.count(&:correct?)
      { user_id: user.id, first_name: user.first_name, last_name: user.last_name,
        correct_avg_percentage: calculate_performance_average(correct_responses, responses.length) }
    end
  end
end
