Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "users#index"

  resources :users do
    resources :posts
  end
  resources :posts, only: :index
  resources :departments
end
