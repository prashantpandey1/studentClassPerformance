# frozen_string_literal: true

require 'benchmark/ips'

r1 = StudentsPerformance.new('test', 1).get_student_details
r2 = StudentsPerformance.new('test', 1).analyze

Rails.logger.debug r1 == r2

Benchmark.ips do |x|
  x.config(time: 20, warmup: 5)

  x.report('get_student_details') do
    StudentsPerformance.new('test', 1).get_student_details
  end

  x.report('analyze') do
    StudentsPerformance.new('test', 1).analyze
  end
  x.compare!
end
