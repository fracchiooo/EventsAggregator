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

  resources :events do
    resources :comments, only: [:create, :destroy, :update ] do
      resources :like_comments, only: [:create, :destroy]
      resources :segnala_cs, only: [:create]
    end
  end

  #resources :like_comments, only: [:create, :destroy]
  #resources :segnala_cs, only: [:create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  #root "comments#index"
end
