Rails.application.routes.draw do
  namespace :filesystem do
    root to: 'directories#index'
    resources :directories
    resources :files
  end
end
