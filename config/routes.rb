Rails.application.routes.draw do
  root 'pages#home'
  get '/home', to: "pages#home"
  get '/faq', to: "pages#faq"
  get '/contatti', to: "pages#contatti"

  devise_for :users, :controllers => {
    :registrations => "users/registrations",
    :sessions => "users/sessions",
    :passwords => "users/passwords",
    :omniauth_callbacks => "users/omniauth_callbacks"
  }

  resources :segnala_cs do
    member do
      patch :elimina_commento, :blocca_utente
    end
  end

  resources :users do
    member do
      patch :blocca_utente, :rendi_amministratore
    end
  end

  post '/like_events', to: "like_events#create"
  post '/favorite_events', to: "favorites#update"

  resources :events do
    resources :comments, only: [:create, :destroy, :update ] do
      resources :like_comments, only: [:create, :destroy]
      resources :segnala_cs, only: [:create]
    end
  end

  get '/oauth2/redirect', to: 'oauth2#redirect', as: 'oauth2_redirect'
  get '/oauth2/callback', to: 'oauth2#callback', as: 'oauth2_callback'
  
  get '/calendar/add_event', to: 'calendar#add_event', as: 'calendar_add_event'

  get '/drive/login', to: 'drive#login', as: 'drive_login'
  post '/drive/logout', to: 'drive#logout', as: 'drive_logout'
  post '/drive/add_media', to: 'drive#add_media', as: 'drive_add_media'

  #resources :like_comments, only: [:create, :destroy]
  #resources :segnala_cs, only: [:create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  #root "comments#index"
end
