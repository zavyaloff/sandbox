# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: 'users#show', as: :authenticated_root
    get '/user', to: 'users#show'
    resources :microposts do
      resources :comments, shallow: true
    end
  end

  unauthenticated do
    root to: 'static_pages#home'
  end

  devise_scope :user do
    get '/sign_in', to: 'devise/sessions#new'
    get '/sign_up', to: 'devise/registrations#new'
    get '/reset_password', to: 'devise/passwords#new'
    get 'users/:id', to: 'users#show', as: :users
    get '/user', to: 'devise/sessions#new'
    get '/user/edit', to: 'devise/sessions#new'
    resources :users
  end

  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  match '*unmatched', to: 'application#route_not_found', via: :all

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
