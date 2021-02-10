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
      # mount_devise_token_auth_for 'Merchant', at: 'auth', controllers: {
        # sessions: 'api/v1/sessions'
      # }
      resources :payments, only: [:create]
    end
  end



  match 'users/sign_in' => 'users/sessions#new', via: 'get'
  match 'users/sign_in' => 'users/sessions#create', via: 'post'
  root to: "home#index"
  
end
