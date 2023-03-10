# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  constraints format: :json do
    resources :students, only: [:index]
    resources :subjects, only: [:index]
    resources :class_performance, only: [:index]
  end

  get 'all_students', action: :index, controller: 'students'
  get 'all_students/:quiz_type', action: :index, controller: 'students'
  get 'students/:quiz_type', action: :index, controller: 'students'
  get 'class_information', action: :index, controller: 'class_performance'
  get 'subject_performance', action: :index, controller: 'subjects'
end
