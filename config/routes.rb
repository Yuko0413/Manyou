Rails.application.routes.draw do
  root 'tasks#index'

  # セッションのルーティング

  resources :sessions
  resources :tasks
  resources :users, only: [:new, :create, :edit, :update, :show, :destroy]

  namespace :admin do
    resources :users
  end
end


