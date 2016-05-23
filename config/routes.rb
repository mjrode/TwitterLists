Rails.application.routes.draw do

  resources :lists do 
    member  do
      get :view_friends
    end
  end
  post '/add_friends', to: "lists#add_friends"


  get  'pages/home'
  root 'pages#home'

  get 'friends/index'


  get 'sessions/create'
  get 'sessions/destroy'
  get '/auth/:provider/callback', to: 'sessions#create'

end
