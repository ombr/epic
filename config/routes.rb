require 'resque_web'
Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  default_url_options host: ENV['DOMAIN']
  authenticated :user do
    ResqueWeb::Engine.eager_load! if Rails.env.development?
    mount ResqueWeb::Engine => '/resque'
  end
  resources :images, only: [:show, :create, :index, :new] do
    collection do
      get :add
    end
  end
  root to: 'images#index'
end
