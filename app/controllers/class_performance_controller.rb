# frozen_string_literal: true

# Controller for the class performance endpoint.
class ClassPerformanceController < ApplicationController
  # Renders the analysis of the class performance.
  #
  # @return [JSON] The analysis of the class performance.
  def index
    render json: ClassPerformance.new.analyze
  end
end
