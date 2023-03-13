# frozen_string_literal: true
# SubjectsPerformance
class SubjectsPerformance
  include PerformanceAverage

  def analyze(quiz_type)
    question_data = Question.joins(response: :quiz)
                            .select('questions.subject, responses.correct, quizzes.user_id')
                            .where(quizzes: { completed: true })
    question_data = question_data.where(quizzes: { quiz_type: }) if quiz_type.present?
    question_data.group_by(&:subject).transform_values do |questions|
      questions.group_by(&:user_id).transform_values do |responses|
        get_average(responses.count(&:correct?), responses.count)
      end
    end
  end
end
