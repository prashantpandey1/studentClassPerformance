# frozen_string_literal: true

# This module provides method for calculating avergae performance
module PerformanceAverage
  def calculate_performance_average(correct_responses, total_responses)
    ((correct_responses * 100).to_f / total_responses).round(2)
  end
end
