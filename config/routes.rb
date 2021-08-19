Rails.application.routes.draw do
  namespace :filesystem do
    resources :directories
    resources :files
  end
end
