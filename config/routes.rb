Rails.application.routes.draw do
  get 'users_departments/new'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "users#index"

  resources :users do
    resources :posts
  end
  resources :posts, only: :index
  resources :departments
  resources :prefectures, only: :index

  resources :users_departments, only: %w[edit update destroy]

end
