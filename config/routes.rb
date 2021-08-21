Rails.application.routes.draw do
  namespace :filesystem do
    resources :directories
    resources :files
  end

  namespace :products do
    resources :segments
    resources :products
  end
end
