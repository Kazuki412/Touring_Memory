Rails.application.routes.draw do
  namespace :public do
    get 'notifications/index'
  end

  root to: "public/homes#top"
  # ユーザー用
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  #管理者用
  devise_for :admin, skip: [:passwords], controllers: {
    sessions: "admin/sessions"
  }

  #ユーザー用
  scope module: :public do
    resources :blogs, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resource :favorite, only: [:create, :destroy]
      resources :blog_comments, only: [:create, :destroy]
    end
    resources :users, only: [:show, :edit, :update] do
      member do
        get :follows, :followers
        get :blocks
      end
        resource :relationship, only: [:create, :destroy]
        resource :block, only: [:create, :destroy]
    end
    resources :messages, only: [:create]
    resources :rooms, only: [:create, :index, :show, :destroy]
    resources :events, only: [:new, :create, :show, :edit, :update, :destroy]
    resources :notifications, only: [:index] do
      member do
        patch :mark_as_read
      end
    end
  end

  #管理者用
  get "admin" => "admin/users#index"
  namespace :admin do
    resources :users, only: [:show, :update]
    resources :blogs, only: [:index, :show, :destroy]
    resources :comments, only: [:index, :destroy]
  end
end
