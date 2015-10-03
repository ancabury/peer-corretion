Rails.application.routes.draw do
  namespace :admin do
    root to: 'home#index'
  end
  devise_for :admin, only: :sessions

  root to: 'user/users#index'
  namespace :user do
    root to: 'usesr#index'
  end
  devise_for :users, only: [:sessions, :passwords]
end
