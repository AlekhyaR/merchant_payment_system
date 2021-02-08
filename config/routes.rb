Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      registrations: 'users/registrations'
      # sessions: 'users/sessions'
    }

  match 'users/sign_in' => 'users/sessions#new', via: 'get'
  match 'users/sign_in' => 'users/sessions#create', via: 'post'
  root to: "home#index"
end
