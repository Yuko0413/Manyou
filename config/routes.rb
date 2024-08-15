Rails.application.routes.draw do
  root 'tasks#index'

  resources :sessions, only: [:new, :create, :destroy]
  #delete '/logout', to: 'sessions#destroy'

  resources :tasks do
    member do
      patch :complete
    end
    collection do
      get :completed
    end
  end


  #resources :tasks
  resources :users, only: [:new, :create, :edit, :update, :show, :destroy]
  resources :labels, only: [:index, :new, :create, :edit, :update, :destroy]

  namespace :admin do
    resources :users
  end

  # エラーページのルーティング
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  # テスト用ルーティング
  get 'test_404', to: 'errors#not_found'
  get 'test_500', to: 'errors#internal_server_error'
end
