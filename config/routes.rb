Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :groups, only: [:index, :new, :create] do
    resources :entities, only: [:index, :new, :create]
  end

  root "splash#index"
end
