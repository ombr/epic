require 'resque_web'
Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  default_url_options host: ENV['DOMAIN']
  authenticated :user do
    ResqueWeb::Engine.eager_load! if Rails.env.development?
    mount ResqueWeb::Engine => '/resque'
  end

  resources :events, only: [:show] do
    resources :clients, only: [:new, :create]
  end

  resources :clients, only: [] do
    resources :events, only: [] do
      resources :images, only: [:index, :show]
    end
  end

  resources :orders, only: [:destroy, :create]

  resources :images, only: [:create, :show] do
    collection do
      get :add
    end
  end
  root to: 'images#index'
end
