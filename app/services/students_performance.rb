class StudentsPerformance
  def initialize(quiz_type, page_num = 1)
    @users = User.includes(:quizzes => :responses).page(page_num)
    @quiz_type = quiz_type
   end

  def get_student_details
    @details = []
    @users.each do |user|
        if @quiz_type
            @quizzes = user.quizzes.where(quiz_type: @quiz_type)
        else
            @quizzes = user.quizzes
        end
        @responses = Response.where(quiz_id: @quizzes.pluck(:id))
        @correct_responses = Response.where(quiz_id: @quizzes.pluck(:id), correct:true)
        @correct_avg_percentage = get_average(@correct_responses.length, @responses.length)
        data = {user_id: user.id, first_name: user.first_name, last_name: user.last_name, correct_avg_percentage:@correct_avg_percentage}
        @details << data
    end
    @details
  end

  def get_average(correct_responses, total_responses)
    (correct_responses * 100).to_f/(total_responses)
  end

end