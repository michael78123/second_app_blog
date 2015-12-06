Rails.application.routes.draw do
  namespace :account do
    resources :posts
    resources :groups
  end
  devise_for :users
  root 'groups#index'

  resources :groups do
    member do
      post :join
      post :quit
    end

    resources :posts
  end
end
