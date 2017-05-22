Rails.application.routes.draw do
  root 'dashboard#index'

  get 'dashboard', to: "dashboard#index"

  resources :companies do

    resources :contacts

    resources :jobs, except:[:index] do
      resources :comments
    end
  end

  resources :categories
  resources :jobs, only: [:index]
end
