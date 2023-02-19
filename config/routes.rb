Rails.application.routes.draw do
  root "users#index"

  resources :users do
    resources :posts
  end
  resources :posts, only: :index
  resources :departments
  resources :prefectures, only: :index
  resources :birthplaces, only: %i(index show)

  resources :users_departments, only: %i(edit update destroy)
end
