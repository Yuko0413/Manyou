Rails.application.routes.draw do
  root 'tasks#index'

  # セッションのルーティング
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :tasks
  resources :users, only: [:new, :create, :edit, :update, :show]

  namespace :admin do
    resources :users
  end
end


