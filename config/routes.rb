Rails.application.routes.draw do
  get "login" => 'sessions#new'

  post 'sessions/create'

  delete "destroy" => 'sessions#destroy'

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Define root path
  root 'users#index'
end
