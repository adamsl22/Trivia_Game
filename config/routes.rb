Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/', to: 'games#welcome', as: 'welcome'
  get '/games/:id/new_game', to: 'games#new_game', as: 'new_game'
  post '/games/:id/game_user', to: 'games#game_user', as: 'game_user'
  get '/games/:id/set_target_points', to: 'games#set_target_points', as: 'target_points'
  patch '/games/:id/update_tp', to: 'games#update_tp', as: 'update_tp'
  get 'games/:id/categories', to: 'games#categories', as: 'categories'
  post 'games/:id/api_request', to: 'games#api_request', as: 'api_request'
  get 'games/:id/question', to: 'games#question', as: 'question'
  post 'games/:id/guess', to: 'games#guess', as: 'guess'
  get 'games/:id/result', to: 'games#result', as: 'result'
  post 'games/:id/end_turn', to: 'games#end_turn', as: 'end_turn'
  get 'games/:id/winner', to: 'games#winner', as: 'winner'

  get '/signup', to: 'users#new', as: 'new_user'
  post '/users', to: 'users#create'
  get '/:id/profile', to: 'users#show', as: 'user'
  get '/users', to: 'users#index', as: 'index'
  get '/profile', to: 'users#profile', as: 'profile'
  get '/edit_profile', to: 'users#edit', as: 'edit_profile'
  patch '/:id/profile', to: 'users#update'

  get '/login', to: 'session#new', as: 'new_session'
  post '/sessions', to: 'session#create'
  delete '/logout', to: 'session#destroy'

end
