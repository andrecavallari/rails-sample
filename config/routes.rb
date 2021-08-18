Rails.application.routes.draw do
  namespace :filesystem do
    root to: 'directories#index'
    resources :directories do
      resources :files
    end
  end
end
