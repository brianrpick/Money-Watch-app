Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # creates restful routs for you (CRUD)
  resources :users, :expenses, :transactions
  get '/', to: 'pages#landing'

  get '/settings', to: "users#settings"

  get '/home', to: "transactions#home"
  get '/other', to: "transactions#other"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  get "/calendar", to: "expenses#new"

  get "/expenses/:id/calendar", to: "expenses#calendar"

  namespace :api do
    namespace :v1 do
      resources :users
    end
  end
end
