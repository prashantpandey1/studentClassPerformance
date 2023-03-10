# frozen_string_literal: true

class SubjectsController < ApplicationController
  def index
    @details = SubjectsPerformance.new.get_subject_performance
    render json: @details
  end
end
