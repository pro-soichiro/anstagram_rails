Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :users, :controllers => {:registrations => "users/registrations"}
  devise_scope :user do
    get "/users/sign_up/thanks", to: "users/registrations#thanks"
  end
  root "users#index"

  resources :users, except: %i(new create) do
    resources :posts
  end
  resources :posts, only: :index
  resources :departments
  resources :prefectures, only: :index
  resources :birthplaces, only: %i(index show)

  resources :users_departments, only: %i(edit update destroy)
end
