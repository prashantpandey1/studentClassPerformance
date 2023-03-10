# frozen_string_literal: true

class StudentsController < ApplicationController
  def index
    @student_data = StudentsPerformance.new(params[:quiz_type], params[:page]).get_student_details
    render json: @student_data
  end
end
