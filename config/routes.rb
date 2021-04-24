Rails.application.routes.draw do
  root to: 'user_sessions#new'
  resources :users

  # sessions
  get '/login' => 'user_sessions#new', :as => :login
  get '/user_sessions/ping' => 'user_sessions#ping', :as => :ping
  post '/logout' => 'user_sessions#destroy', :as => :logout
  post '/user_sessions' => 'user_sessions#create'

  # posts
  get "/posts" => "posts#index"
  get "/posts/:id" => "posts#show"
  post "/posts" => "posts#create"
  put "/posts/:id" => "posts#update"
  delete "/posts/:id" => "posts#destroy"
end
