Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admin/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'serch' => 'serches#serch'
  scope module: :public do
    devise_for :users, controllers: {
      sessions: 'public/sessions',
      passwords: 'public/passwords',
      registrations: 'public/registrations'
    }

    root to: 'homes#top'
    get 'about' => 'homes#about'
    get 'my_page' => 'users#my_page'
    get 'users/confirm' => 'users#confirm'
    patch 'users/withdraw' => 'users#withdraw'
    get 'favorites' => 'users#favorites'
    get '/search/genres/:id' => 'searches#genre', as: 'genre_search'
    get 'search' => 'searches#search'
    resources :users, only: %i[edit update index show] do
      resource :relationships, only: %i[create destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    resources :posts, only: %i[new create index show destroy] do
      resource :favorites, only: %i[create destroy]
      get 'favorites/index' => 'users/index'
      resources :post_comments, only: %i[create destroy]
    end
    resources :notifications, only: :index
  end

  namespace :admin do
    resources :users, only: %i[edit update index show destroy]
    resources :genres, only: %i[create edit update index destroy]
  end
end
