Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts
  get '/users/logout', to: "users#logout", as: "logout_user"
  get '/users/login', to: "users#signin", as: "signin_user"
  post "/users/login", to: "users#login", as: "login_user"
  resources :users
  resources :sentances, only: [:create]
end
