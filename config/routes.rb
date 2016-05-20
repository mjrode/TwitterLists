Rails.application.routes.draw do

  resources :lists do 
    member  do
      get :add_friends
    end
  end


  get  'pages/home'
  root 'pages#home'

  get 'friends/index'


  get 'sessions/create'
  get 'sessions/destroy'
  get '/auth/:provider/callback', to: 'sessions#create'

end
