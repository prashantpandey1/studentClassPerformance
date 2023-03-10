# frozen_string_literal: true

class ClassPerformanceController < ApplicationController
  def index
    @class_performance = ClassPerformance.new.get_class_performance
    render json: @class_performance
  end
end
