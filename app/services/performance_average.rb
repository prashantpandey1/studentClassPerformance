# frozen_string_literal: true

#  PerformanceAverage
module PerformanceAverage
  def get_average(correct_responses, total_responses)
    ((correct_responses * 100).to_f / total_responses).round(2)
  end
end
