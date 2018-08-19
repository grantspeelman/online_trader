# frozen_string_literal: true

uuid_regex = /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/
OnlineTrader::Application.routes.draw do
  resources :users, except: %i[new create destroy], constraints: { id: uuid_regex } do
    collection do
      get 'search'
    end
    resources :wants, only: %i[index]
    resources :haves, only: %i[index]
  end

  resources :haves, constraints: { id: uuid_regex }
  resources :wants, constraints: { id: uuid_regex }

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
