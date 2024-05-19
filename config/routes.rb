Rails.application.routes.draw do
  get 'blogs/new'
  get 'blogs/index'
  get 'blogs/show'
  get 'blogs/edit'
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
end
