# frozen_string_literal: true

class SubjectsPerformanceController < ApplicationController
  def index
    render json: SubjectsPerformance.new.analyze(params[:quiz_type])
  end
end
