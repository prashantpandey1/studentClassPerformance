# frozen_string_literal: true

class ClassPerformance
  include PerformanceAverage

  def initialize
    @quizzes = Quiz.eager_load(:responses).where(completed: 1)
  end

  def get_class_performance
    practice_quizes = @quizzes.select(&:practice?)
    test_quizzes = @quizzes.select(&:test?)
    responses = @quizzes.collect(&:responses).flatten
    correct_responses = responses.select(&:correct?)
    pq_responses = practice_quizes.collect(&:responses).flatten
    pq_correct_responses = pq_responses.select(&:correct?)
    tq_responses = test_quizzes.collect(&:responses).flatten
    tq_correct_responses = tq_responses.select(&:correct?)

    {
      total_quizzes_complted: @quizzes.count(&:completed?),
      total_practice_quizes_completed: practice_quizes.length,
      total_test_quizes_completed: test_quizzes.length,
      total_responses: responses.length,
      total_correct_responses: correct_responses.length,
      total_practice_responses: pq_responses.length,
      total_practice_correct_responses: pq_correct_responses.length,
      total_test_responses: tq_responses.length,
      total_test_correct_responses: tq_correct_responses.length,
      total_average_percentage: get_average(correct_responses.length, responses.length),
      practice_average_percentage: get_average(pq_correct_responses.length, pq_responses.length),
      test_average_percentage: get_average(tq_correct_responses.length, tq_responses.length)
    }
  end

 
end
