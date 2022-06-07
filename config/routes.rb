Rails.application.routes.draw do

  get 'relationships/followings'
  get 'relationships/followers'
  root to: 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'

  devise_for :users
  resources :users, only: [:index, :show, :edit, :update]

  resources :books, only: [:index, :show, :edit, :create, :update, :destroy] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
