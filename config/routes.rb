Rails.application.routes.draw do

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
    resources :blogs, only: [:new, :create, :index, :show, :edit, :update, :destroy]
    resources :users, only: [:show, :edit, :update]
  end

  #管理者用
  get "admin" => "admin/users#index"
  namespace :admin do
    resources :users, only: [:show, :update]
    resources :blogs, only: [:index, :show, :destroy]
    resources :comments, only: [:index, :destroy]
  end
end
