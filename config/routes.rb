Rails.application.routes.draw do
  resources :users, only: [:show, :new, :index, :create]
  resources :user_classrooms, only: [:new, :create, :show]
  resources :users do
    resources :events
    resources :profiles, only: [:index]
  end

  namespace :staff do
    resources :dashboards, only: [:index]
    resources :schools
    resources :classrooms
    resources :events
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

end
