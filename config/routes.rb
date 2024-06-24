Rails.application.routes.draw do
  scope "(:locale)", locale: /en|ja/ do
    root 'tasks#index'

    resources :tasks
      # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end
end
