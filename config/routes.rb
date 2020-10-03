Rails.application.routes.draw do
  root 'home#top'
  get 'search/users', to: 'search#users', as: 'user_search'
  get 'search/universities', to: 'search#universities', as: 'university_search'
  get '/microposts', to: 'microposts#new'
  get '/microposts/:id/comments', to: 'microposts#show'
  get '/my_page/:id', to: 'users#my_page', as: 'my_page'

  devise_for :users
  resources :users, only: [:index, :show] do
    member do
      get :follow
    end
    resources :book_categories, only: [:new, :create, :destroy]
    resources :week_targets, except: :show
  end
  patch '/users/:id', to: 'users#update', as: 'user_update'

  resources :books, only: [:index, :create, :show, :update, :destroy]
  resources :book_registers, only: [:create, :destroy]
  resources :microposts, except: [:index, :new, :edit] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  resources :notifications, only: :index
end
