Rails.application.routes.draw do
  root 'companies#index'

  get 'dashboard', to: "dashboard#index"

  resources :companies do

    resources :contacts

    resources :jobs do
      resources :comments
    end
  end

  resources :categories
end
