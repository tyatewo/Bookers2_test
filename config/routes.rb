Rails.application.routes.draw do

  root to: 'homes#top'
  get "/home/about" => "homes#about", as: "about"
  devise_for :users

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end


  resources :books, only: [:create, :index, :show, :edit, :destroy, :update] do
    get 'favorite'
  end
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    get 'search' => 'users#search'
  end

  resources :groups do
    get "join" => "groups#join"
  end

end