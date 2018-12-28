Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/posts/search', to: "posts#search", as: "search_path"
  resources :posts
  get '/users/logout', to: "users#logout", as: "logout_user"
  get '/users/login', to: "users#signin", as: "signin_user"
  post "/users/login", to: "users#login", as: "login_user"
  resources :users do
    resources :posts, only: [:show, :new]
  end
  resources :sentances, only: [:create]
  resources :comments, only: [:create, :delete, :edit]
end
