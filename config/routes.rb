# frozen_string_literal: true

uuid_regex = /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/
Rails.application.routes.draw do
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

  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match '/auth/failure', to: 'sessions#failure', via: [:get, :post]

  match '/login', to: 'sessions#new', via: [:get, :post]
  match '/logout', to: 'sessions#destroy', via: [:delete, :post]

  match '/me', to: 'home#me', via: [:get, :post]

  root to: 'home#index'
end
