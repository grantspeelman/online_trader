# frozen_string_literal: true

OnlineTrader::Application.routes.draw do
  resources :users, except: %i[new create :destroy] do
    collection do
      get 'search'
    end
    resources :wants, only: %i[index]
    resources :haves, only: %i[index]
  end

  resources :haves
  resources :wants

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
