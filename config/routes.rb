Rails.application.routes.draw do

  resources :lists do 
    member  do
      get :select_friends
      get :view
      post :add_friends
    end
    collection do 
      get :import
    end
  end

  resources :friends do 
    collection do 
      get :unassigned
    end
  end
  # post '/add_friends', to: "lists#add_friends"


  get  'pages/home'
  root 'pages#home'

  get 'friends/index'


  get 'sessions/create'
  delete '/logout', to: 'sessions#destroy'
  get '/auth/:provider/callback', to: 'sessions#create'

end
