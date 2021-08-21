# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :filesystem do
    resources :directories
    resources :files
  end

  namespace :store do
    resources :segments
    resources :products
  end
end
