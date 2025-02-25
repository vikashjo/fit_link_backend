Rails.application.routes.draw do
  get 'setts/index'
  get 'setts/create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  post 'login', to: 'authentication#login'
  post 'register', to: 'users#create'
  get 'profile', to: 'users#show'

  resources :users, only: [:update, :destroy]
  resources :workout_plans do
    member do
      post :clone_template
    end
    resources :workout_plan_exercises, only: [:create, :update, :destroy]
  end
  resources :workouts do
    resources :setts
  end
end
