Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :users, :controllers => {:registrations => "users/registrations"}
  devise_scope :user do
    get "/users/sign_up/thanks", to: "users/registrations#thanks"
  end
  root "posts#index"

  resources :users, except: %i(new create destroy) do
    resources :posts, except: %i(edit update show), controller: "users/posts"
  end
  resources :posts, only: %i(index show)
  resources :likes, only: %i(create destroy)
  resources :departments
  resources :prefectures, only: :index
  resources :birthplaces, only: %i(index show)

  resources :users_departments, only: %i(edit update destroy)
end
