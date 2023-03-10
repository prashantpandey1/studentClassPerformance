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
    quiz_types.each do |quiz_type|
      quizzes = @quizzes.where(quiz_type: quiz_type)
      quiz_data = {}
      quizzes.each do |quiz|
        responses = quiz.responses.to_a
        correct_responses = responses.count(&:correct?)
        quiz_data[quiz_type] = {}
        quiz_data[quiz_type][:test_quizzes] = quiz_data[quiz_type][:test_quizzes] ? quiz_data[quiz_type][:test_quizzes] + responses.length : responses.length
        quiz_data[quiz_type][:test_quizzes_corrected] = quiz_data[quiz_type][:test_quizzes_corrected] ? quiz_data[quiz_type][:test_quizzes_corrected] + correct_responses : correct_responses
        quiz_data[quiz_type][:practice_quizzes] = quiz_data[quiz_type][:practice_quizzes] ? quiz_data[quiz_type][:practice_quizzes] + responses.length : responses.length
        quiz_data[quiz_type][:practice_quizzes_corrected] = quiz_data[quiz_type][:practice_quizzes_corrected] ? quiz_data[quiz_type][:practice_quizzes_corrected] + correct_responses : correct_responses
      end
      class_performance[:total_quizzes_answered] = quiz_data[quiz_type][:test_quizzes] + quiz_data[quiz_type][:practice_quizzes]
      if (quiz_type == 'test')
        class_performance[:test_avg_percentage] = get_average(quiz_data[quiz_type][:test_quizzes_corrected], quiz_data[quiz_type][:test_quizzes])
      elsif (quiz_type == 'practice')
        class_performance[:practice_avg_percentage] = get_average(quiz_data[quiz_type][:test_quizzes_corrected], quiz_data[quiz_type][:practice_quizzes])
      end
    end
    class_performance
  end

  def test
    class_performance = {
        total_quizzes: @quizzes.length,
        total_quizzes_completed: @quizzes.count(&:completed?)
      }
      quizzes = @quizzes.to_a
      quizzes.each do |quiz|

      end

  end



  def get_average(correct_responses, total_responses)
    (correct_responses * 100).to_f / total_responses
  end
end
