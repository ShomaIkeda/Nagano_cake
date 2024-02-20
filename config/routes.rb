Rails.application.routes.draw do

  #顧客用
  
devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  scope module: :public do
    
  root to: 'homes#top'

  get 'top', to: 'homes#top'
  get 'about', to: 'homes#about'

  resources :items, only: [:show, :index,]
  resources :cart_items, only: [ :index, :update, :destroy,:destroy_all,:create]
  resources :orders, only: [:new, :confirm, :complete, :create, :index, :show]
  resources :customers, only: [:new, :show]
  
  get '/customers/information/edit', to: 'customers#edit' , as: 'edit_information'
  patch '/customers/information', to: 'customers#update', as: 'update_information'

  get 'customer/my_page', to: 'customers#show'
  post 'orders/confirm', to: 'orders#confirm'
  get 'complete', to: 'orders#complete'

  
  get 'customer/sign_in', to: 'customers#new'
  get 'customer/information/edit', to: 'customers#edit'
  get 'customer/orders', to: 'customers#index'
  get 'customer/confirm', to: 'customers#confirm'

  patch 'customer/:id/withdraw', to: 'customers#withdraw',as: 'customer_withdraw'
  delete 'destroy_all_cart_items', to: 'cart_items#destroy_all', as: 'destroy_all_cart_items'

  end




  #管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
  
  root to: "homes#top"  
  get 'top', to: 'homes#top'
  resources :customers, only: [:index, :show, :edit, :update]
  resources :items, only: [:new, :create, :show, :index, :edit, :update]
  resources :orders, only: [:index, :show]

  delete 'admin/sign_out', to: 'admin/sessions#destroy', as: :destroy_admin_session

 
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end