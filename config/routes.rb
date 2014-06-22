Rails.application.routes.draw do
  default_url_options host: ENV['DOMAIN']
  resources :images, only: [:show, :create, :index]
  root to: 'images#index'
end
