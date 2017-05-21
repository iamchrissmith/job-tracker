Rails.application.routes.draw do
  root 'companies#index'
  resources :companies do
    resources :jobs
  end

  resources :categories
end
