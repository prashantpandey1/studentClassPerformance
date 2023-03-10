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

  get 'students/:quiz_type', action: :index, controller: 'students'
end
