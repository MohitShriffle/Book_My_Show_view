Rails.application.routes.draw do
  devise_for :users, controllers:
  {
    sessions: 'users/sessions'
    }
 
  resources :users
  resources :theaters
  resources :screens
  resources :movies
  resources :shows
  resources :tickets
  post 'users/login', to: 'application#login'
  resources :movies
  get "/search_movie_by_name", to: "movies#search_movie_by_name"
  post"/search_movie", to: "movies#search_movie"
  get "/search_tickets",to: "tickets#search_tickets"
  root "users#index"
  # root "users#index"
  get "/login", to: "users#login"
end
