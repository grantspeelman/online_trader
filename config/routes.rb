# frozen_string_literal: true

OnlineTrader::Application.routes.draw do
  resources :users do |_u|
    collection do
      get 'search'
    end
    resources :wants, except: %i[show edit update destroy]
    resources :haves, except: %i[show edit update destroy]
  end

  resources :haves
  resources :wants
  resources :trades, except: [:destroy]

  resources :cards do
    collection do
      get 'search'
    end
  end

  match '/auth/:provider/callback', to: 'sessions#create'
  match '/auth/failure', to: 'sessions#failure'

  match '/login', to: 'sessions#new'
  match '/logout', to: 'sessions#destroy'

  match '/me', to: 'home#me'

  root to: 'home#index'
end
