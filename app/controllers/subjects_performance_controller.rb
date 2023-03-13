# frozen_string_literal: true

# Controller for the subjects performance endpoint.
class SubjectsPerformanceController < ApplicationController
  # Renders the analysis of the subjects' performance based on the quiz type parameter.
  #
  # @param [String] quiz_type The type of quiz for which to analyze the subjects' performance.
  # @return [JSON] The analysis of the subjects' performance.
  def index
    render json: SubjectsPerformance.new.analyze(params[:quiz_type])
  end
end
