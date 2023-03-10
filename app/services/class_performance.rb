# frozen_string_literal: true

class ClassPerformance
  def initialize
    @quizzes = Quiz.eager_load(:responses)
  end

  def get_class_performance
    class_performance = {
      total_quizzes: @quizzes.length,
      total_quizzes_answered: @quizzes.count(&:completed?)
    }
    quiz_types = ["test", "practice"]
    quiz_types.each do |quiz_type|
      quizzes = @quizzes.where(quiz_type: quiz_type)
      quizzes.each do |quiz|
        responses = quiz.responses.to_a
        correct_responses = responses.count(&:correct?)
        if (quiz_type == 'test')
          class_performance[:test_avg_percentage] = get_average(correct_responses, responses.length)
        elsif (quiz_type == 'practice')
          class_performance[:practice_avg_percentage] = get_average(correct_responses, responses.length)
        end
      end
    end
    class_performance
  end

  def get_average(correct_responses, total_responses)
    (correct_responses * 100).to_f / total_responses
  end
end
