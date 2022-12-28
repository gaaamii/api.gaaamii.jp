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

  # admin only
  namespace :admin do
    get "/posts" => "posts#index"
    get "/posts/:post_id" => "posts#show"
  end

  # cloudinary signature
  get '/cloudinary_signature' => 'cloudinary_signature#show'
end
