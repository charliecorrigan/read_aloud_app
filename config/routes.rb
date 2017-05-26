Rails.application.routes.draw do
  resources :users, only: [:show, :new, :index, :create]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

end
