Rails.application.routes.draw do
  resources :users, only: [:show, :new, :index, :create]

  resources :users do
    resources :events
    resources :profiles, only: [:index]
  end

  namespace :staff do
    resources :dashboards, only: [:index]
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

end
