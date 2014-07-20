require 'resque_web'
Rails.application.routes.draw do
  default_url_options host: ENV['DOMAIN']
  # authenticated :user do
    mount ResqueWeb::Engine => '/resque'
  # end
  resources :images, only: [:show, :create, :index, :new] do
    collection do
      get :add
    end
  end
  root to: 'images#index'
end
