# frozen_string_literal: true

class ClassPerformance
  def initialize
    @users = User.includes(quizzes: :responses)
  end

  def get_class_performance
    @performance_data = []
    @users.each do |user|
      @total_quiz_taken = user.quizzes
      @answered_quizzes = @total_quiz_taken.where(completed: true)
      @test_quizzes = @total_quiz_taken.where(quiz_type: 'test')
      @practice_quizzes = @total_quiz_taken.where(quiz_type: 'practice')
      @test_responses = Response.where(quiz_id: @test_quizzes.pluck(:id))
      @practice_responses = Response.where(quiz_id: @practice_quizzes.pluck(:id))
      @test_correct_responses = Response.where(quiz_id: @test_quizzes.pluck(:id), correct: true)
      @practice_correct_responses = Response.where(quiz_id: @practice_quizzes.pluck(:id), correct: true)
      @user_test_avg = get_average(@test_correct_responses.length, @test_responses.length)
      @user_practice_avg = get_average(@practice_correct_responses.length, @practice_responses.length)
      data = { user_id: user.id, first_name: user.first_name, last_name: user.last_name,
               user_test_avg: @user_test_avg, user_practice_avg: @user_practice_avg, total_quiz_taken: @total_quiz_taken.length, answered_quizzes: @answered_quizzes.length }
      @performance_data << data
    end
    @performance_data
  end

  def get_average(correct_responses, total_responses)
    (correct_responses * 100).to_f / total_responses
  end
end
