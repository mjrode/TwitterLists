Rails.application.routes.draw do
 # resources
  resources :users

  resources :lists do
    member  do
      get :select_friends
      get :view
      post :add_friends
    end
    collection do
      post :add_multiple_friends
      get :import
    end
  end

  resources :friends do
    collection do
      get :all
    end
  end

  # pages
  get 'pages/home'
  get '/about', to: 'pages#about'
  root 'pages#home'

  # sessions
  post '/update_email', to: 'sessions#update_email'
  get 'sessions/create'
  get '/sessions/set_email', to: 'sessions#set_email'
  delete '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'
  get '/auth/:provider/callback', to: 'sessions#create'
end
