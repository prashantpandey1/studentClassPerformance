# frozen_string_literal: true

class ClassPerformance
  def initialize
    @quizzes = Quiz.eager_load(:responses)
  end

  def get_class_performance
    class_performance = {
      total_quizzes_taken: @quizzes.count(&:completed?)
    }
    quiz_types = ["test", "practice"]
    quiz_data = {}
    quiz_types.each do |quiz_type|
      quizzes = @quizzes.where(quiz_type: quiz_type)
      
      quizzes.each do |quiz|
        responses = quiz.responses.to_a
        correct_responses = responses.count(&:correct?)
        quiz_data[quiz_type] = {}
        quiz_data[quiz_type][:total_quizzes] = quiz_data[quiz_type][:total_quizzes] ? quiz_data[quiz_type][:total_quizzes] + responses.length : responses.length
        quiz_data[quiz_type][:total_quizzes_corrected] = quiz_data[quiz_type][:total_quizzes_corrected] ? quiz_data[quiz_type][:total_quizzes_corrected] + correct_responses : correct_responses
      end
      if quiz_type == "test"
       class_performance[:test_avg_percentage] = get_average(quiz_data[quiz_type][:total_quizzes_corrected], quiz_data[quiz_type][:total_quizzes])
      elsif quiz_type == "practice"
       class_performance[:practice_avg_percentage] = get_average(quiz_data[quiz_type][:total_quizzes_corrected], quiz_data[quiz_type][:total_quizzes])
      end
    end
    class_performance[:total_quizzes_answered] = quiz_data["test"][:total_quizzes] + quiz_data["practice"][:total_quizzes]
    class_performance
  end

  def get_average(correct_responses, total_responses)
    (correct_responses * 100).to_f / total_responses
  end
end
