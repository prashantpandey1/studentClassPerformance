# frozen_string_literal: true

class SubjectsPerformance
  include PerformanceAverage
  def initialize
    @Questions = Question.eager_load(:quiz)
    @Quiz = Quiz.eager_load(:responses)
  end

  def get_subject_performance
    subjects = @Questions.distinct.pluck(:subject)
    subject_data = []
    user_sub_details = {}
    subjects.each do |subject|
      question_ids = @Questions.where(subject: subject).pluck(:id)
      response_details = @Questions.where(response: { question_id: question_ids }).pluck(:quiz_id, :correct)
      data = {}
      response_details.each do |response|
        user = @Quiz.find_by(id: response.first).user_id.to_s
        if data[user].present?
           data[user][:total_count] += 1
           data[user][:correct_answer_count] = response.last == 1 ? data[user][:correct_answer_count] + 1 : 0
        else
          data[user] = {}
          data[user][:total_count] = 1
          data[user][:correct_answer_count] = response.last == 1 ? 1 : 0
          data[user][:user_id] = user.to_i
        end
      end
      data.each do |id, data|
        subject_data << {
                         user_id: data[:user_id],
                         average: get_average(data[:correct_answer_count], data[:total_count])
                        }
     end
     user_sub_details[subject] = subject_data
    end
    user_sub_details
  end
end
