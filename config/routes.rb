Rails.application.routes.draw do
  root 'homes#top'
  get 'home/about' => 'homes#about'
  devise_for :users
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  post 'follow/:id' => 'relationships#create', as: 'follow'
  post 'unfollow/:id' => 'relationships#destroy', as: 'unfollow'
end