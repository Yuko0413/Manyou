Rails.application.routes.draw do
  root 'tasks#index'

  resources :sessions, only: [:new, :create, :destroy]
  #delete '/logout', to: 'sessions#destroy'

  resources :tasks
  resources :users, only: [:new, :create, :edit, :update, :show, :destroy]
  resources :labels, only: [:index, :new, :create, :edit, :update, :destroy]

  namespace :admin do
    resources :users
  end
end
