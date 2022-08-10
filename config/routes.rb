Rails.application.routes.draw do
 #ログアウト用
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  devise_scope :admin do
    get '/admins/sign_out' => 'devise/sessions#destroy'
  end

  # # ユーザー用
    devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
   }
  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
   sessions: "admin/sessions"
  }

 scope module: :public do
  root :to =>"homes#top"

  #ユーザー
   resources :users, only: [:show,:edit,:update,:destroy,:create]
  #商品
   resources :items, only: [:show, :index] do
  #コメント機能
   resources :item_comments, only: [:create, :destroy]
  #いいね機能
   resource :favorites, only: [:create, :destroy]
   end
 end

 namespace :admin do
  root :to =>"homes#top"
  # ジャンル
   resources :genres, only: [:create, :index, :update, :edit,]
  # 商品
   resources :items, only: [:new, :show, :create, :edit, :index, :update]
 end

  devise_scope :admin do
    get '/admins/sign_out' => 'devise/sessions#destroy'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
