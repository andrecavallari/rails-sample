# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  root 'home#index'

  namespace :auth do
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
  end

  resources :tweet_weather, only: %i[create]

  namespace :filesystem do
    resources :directories, except: %i[new edit]
    resources :files, only: %i[create update destroy]
  end

  namespace :store do
    resources :segments, except: %i[new edit show]
    resources :products, except: %i[new edit show]
  end
end
