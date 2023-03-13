# frozen_string_literal: true

class StudentsPerformanceController < ApplicationController
  def index
    render json: StudentsPerformance.new(params[:quiz_type], params[:page]).analyze
  end
end
