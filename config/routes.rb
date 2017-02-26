require 'sidekiq/web'

Rails.application.routes.draw do
  root 'home#index'
  mount Sidekiq::Web => '/sidekiq'
end
