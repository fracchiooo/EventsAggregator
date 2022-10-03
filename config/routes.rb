Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks"}
  resources :comments
  resources :like_comments, only: [:create, :destroy]
  resources :segnala_cs, only: [:create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  #root "comments#index"
end
