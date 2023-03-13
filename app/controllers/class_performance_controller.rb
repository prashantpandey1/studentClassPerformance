# frozen_string_literal: true

class ClassPerformanceController < ApplicationController
  def index
    render json: ClassPerformance.new.analyze
  end
end
