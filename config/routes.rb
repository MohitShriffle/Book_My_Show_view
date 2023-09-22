Rails.application.routes.draw do
  devise_for :users, controllers:
  {
    sessions: 'users/sessions'
    }
   resources :theaters do 
    resources :screens ,shallow: true
   end
   
   resources :screens do 
    resources :shows
   end
   resources :shows do
    resources :tickets 
   end

  resources :users
  resources :theaters

  resources :tickets
  resources :movies do
    resources :shows
  end
  resources :movies
  get "/search_movie_by_name", to: "movies#search_movie_by_name"
  post"/search_movie", to: "movies#search_movie"
  get "/search_tickets",to: "tickets#search_tickets"
  root "users#index"
  get "/login", to: "users#login"
  get "/search_tickets_by_id", to: "tickets#search_tickets_by_id"
end
