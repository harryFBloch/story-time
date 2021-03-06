Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'posts#index'
  get '/posts/search', to: "posts#search", as: "search_path"

  resources :posts do
    get '/comments', to: "comments#comments_for_post"
    get '/next', to: "posts#next"
    get '/sentances', to: 'posts#get_sentance_content_for_post'
  end
  get '/users/logout', to: "users#logout", as: "logout_user"
  get '/users/login', to: "users#signin", as: "signin_user"
  post "/users/login", to: "users#login", as: "login_user"

  # Routes for Google authentication
  get "auth/:provider/callback", to: "users#googleAuth"
  get "auth/failure", to: redirect("/")
  get '/current_user', to: "application#get_current_user"
  resources :users do
    resources :posts, only: [:show, :new]
  end
  resources :sentances, only: [:create]
  resources :comments, only: [:create, :delete, :edit]
end
