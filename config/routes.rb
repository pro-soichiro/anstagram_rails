# frozen_string_literal: true

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  devise_for :users,
             controllers: {
               registrations: 'users/registrations',
               omniauth_callbacks: 'users/omniauth_callbacks'
             }

  devise_scope :user do
    get '/users/sign_up/thanks', to: 'users/registrations#thanks'
  end

  authenticated :user do
    root to: 'users#show', as: :user_root
  end
  root to: redirect('/users/sign_in')

  resources :users, except: %i[new create] do
    resources :posts, except: %i[edit update show], controller: 'users/posts'
    resource :profile, only: %i[edit update], controller: 'users/profile'
  end
  resources :posts, only: %i[index show]
  resources :likes, only: %i[create destroy]
  resources :departments
  resources :prefectures, only: :index
  resources :birthplaces, only: %i[index show]

  resources :users_departments, only: %i[edit update destroy]
end
