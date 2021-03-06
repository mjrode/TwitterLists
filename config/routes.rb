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
      get :find_list
    end
  end
  resources :tweets do
    collection do 
      get :fetch
      get :text
    end
  end

  resources :friends do
    collection do
      get :all
    end
  end
  get '/find_list', to: 'pages#find_list'

  # pages
  get '/pages/home'
  get '/about', to: 'pages#about'
  get '/update_progress', to: 'pages#update_progress'
  root 'pages#home'

  #replies
  post '/replies/create', to: "replies#create"
  #share
  post '/tweets/share', to: "tweets#share"
  post '/tweets/seen', to: 'tweets#seen'


  # sessions
  post '/update_email', to: 'sessions#update_email'
  get '/sessions/create'
  get '/sessions/set_email', to: 'sessions#set_email'
  delete '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'
  get '/auth/:provider/callback', to: 'sessions#create'

end
