Rails.application.routes.draw do
  namespace :admin do
    root to: 'home#index'
    resources :papers do
      resources :corrections
    end
    resources :users
  end
  devise_for :admin, only: :sessions

  root to: 'user/papers#index'
  namespace :user do
    root to: 'users#index'
    resources :papers
  end

  devise_for :users, only: [:sessions, :passwords]
end
