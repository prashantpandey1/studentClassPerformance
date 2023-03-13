# frozen_string_literal: true

# Controller for the students performance endpoint.
class StudentsPerformanceController < ApplicationController
  # Renders the analysis of the students' performance based on the quiz type and page number parameters.
  #
  # @param [String] quiz_type The type of quiz for which to analyze the students' performance.
  # @param [Integer] page The page number of the students to analyze.
  # @return [JSON] The analysis of the students' performance.
  def index
    render json: StudentsPerformance.new(params[:quiz_type], params[:page]).analyze
  end
end
