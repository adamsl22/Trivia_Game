Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :games, only: [:show]
  # resources :users

  get '/', to: 'games#welcome', as: 'welcome'
  get '/games/:id/new_game', to: 'games#new_game', as: 'new_game'
  post '/games/:id/game_user', to: 'games#game_user', as: 'game_user'

  get '/signup', to: 'users#new', as: 'new_user'
  post '/create_account', to: 'users#create'
  get '/profile', to: 'users#show', as: 'user'
  get '/users', to: 'users#index', as: 'index'

  get '/login', to: 'session#new', as: 'new_session'
  post '/sessions', to: 'session#create'
  delete '/logout', to: 'session#destroy'

end
