Rails.application.routes.draw do
  root 'companies#index'
  resources :companies do
    resources :jobs do
      resources :comments
    end
    resource :contacts, only: [:show, :edit]
  end

  resources :categories
end
