Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :games, only: [:show]
  resources :users
  get '/', to: 'games#welcome', as: 'welcome'
  get '/games/:id/new_game', to: 'games#new_game', as: 'new_game'
  post '/games/:id/game_user', to: 'games#game_user', as: 'game_user'
end
