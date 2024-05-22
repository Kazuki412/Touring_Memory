Rails.application.routes.draw do

  root to: "homes#top"
  # ユーザー用
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  #管理者用
  devise_for :admin, skip: [:passwords], controllers: {
    registrations: "admin/registrations",
    sessions: "admin/sessions"
  }

  #ユーザー用
  scope module: public do
    resources :blogs, only[:new, :create, :index, :show, :edit, :update, :destroy]
  end

  #管理者用
  namespace :admin do
    
  end
end
