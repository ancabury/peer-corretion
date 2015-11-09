Rails.application.routes.draw do
  namespace :admin do
    root to: 'home#index'
    resources :papers do
      resources :corrections
      get :download, to: "papers#download"
    end
    resources :users
  end
  devise_for :admin, only: :sessions

  root to: 'user/papers#index'
  namespace :user do
    root to: 'users#index'
    resources :users do
      resources :papers do
        get :download, to: "papers#download"
      end
      resources :corrections
    end
  end

  devise_for :users, only: [:sessions, :passwords]
end
