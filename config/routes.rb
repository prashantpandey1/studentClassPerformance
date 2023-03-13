# frozen_string_literal: true

Rails.application.routes.draw do
  constraints format: :json do
    resources :students_performance, only: [:index]
    resources :subjects_performance, only: [:index]
    resources :class_performance, only: [:index]
  end

  get 'all_students', action: :index, controller: 'students_performance'
  get 'all_students/:quiz_type', action: :index, controller: 'students_performance'
  get 'students/:quiz_type', action: :index, controller: 'students_performance'
  get 'class_information', action: :index, controller: 'class_performance'
  get 'subject_performance', action: :index, controller: 'subjects_performance'
end
