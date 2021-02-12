Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      registrations: 'users/registrations'
    }

  namespace :admins do
    resources :merchants
    resources :transactions, only: [:index]
  end

  namespace :merchants do
    resources :transactions, only: [:index]
  end

  namespace :api do
    namespace :v1 do
      match 'authenticate/sign_in' => 'authentication#create', via: 'post'
      resources :payments, only: [:create]
    end
  end

  match 'admins/logout' => 'admins/sessions#destroy', via: 'delete'
  match 'admins/sign_in' => 'admins/sessions#new', via: 'get'
  match 'admins/sign_in' => 'admins/sessions#create', via: 'post'

  match 'merchants/logout' => 'merchants/sessions#destroy', via: 'delete'
  match 'merchants/sign_in' => 'merchants/sessions#new', via: 'get'
  match 'merchants/sign_in' => 'merchants/sessions#create', via: 'post'
  
  root to: "home#index"
end
