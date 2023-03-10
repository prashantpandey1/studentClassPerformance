# frozen_string_literal: true

class SubjectsPerformance
  def initialize
    @users = User.includes(quizzes: :responses)
  end

  def get_subject_performance
    @subjects = Question.distinct.pluck(:subject)
    @user_sub_details = {}
    @subject_data = []
    @subjects.each do |subject|
      @data = {}
      @question_ids = Question.where(subject: subject).pluck(:id)
      @response_detail = Response.where(question_id: @question_ids).pluck(:quiz_id, :correct)
      @response_detail.each do |detail|
        @user_id = Quiz.find_by(id: detail.first).user_id
        @user = @users.find_by(id: @user_id)
        @user_info = @user_id.to_s
        if @data[@user_info]
          @data[@user_info][:total_count] += 1
          @data[@user_info][:correct_answer_count] =
            detail.last == true ? @data[@user_info][:correct_answer_count] + 1 : 0
        else
          @data[@user_info] = {}
          @data[@user_info][:total_count] = 1
          @data[@user_info][:correct_answer_count] = detail.last == true ? 1 : 0
          @data[@user_info][:user_id] = @user_id
          @data[@user_info][:first_name] = @user.first_name
          @data[@user_info][:last_name] = @user.last_name
        end
      end

      @data.each do |_id, data|
        data[:subject_avg] = get_average(data[:correct_answer_count], data[:total_count])
        user_sub_data = { user_id: data[:user_id], first_name: data[:first_name], last_name: data[:last_name],
                          average: data[:subject_avg] }
        @subject_data << user_sub_data
      end
      @user_sub_details[subject] = @subject_data
    end
    @user_sub_details
  end

  def get_average(correct_responses, total_responses)
    (correct_responses * 100).to_f / total_responses
  end
end
