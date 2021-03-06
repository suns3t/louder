Rails.application.routes.draw do
  resources :friendships
  

  # Session routes
  get "login" => 'sessions#new'
  get 'auth/:provider/callback' => 'sessions#callback'

  post 'sessions/create'

  delete "destroy" => 'sessions#destroy'

  # User routes
  resources :users do
    resources :messages
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Define root path
  root 'users#index'
end
