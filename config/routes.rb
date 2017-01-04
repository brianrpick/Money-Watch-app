Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # creates restful routs for you (CRUD)
  resources :users, :expenses, :transactions
  get '/settings', to: "users#settings"

  get '/', to: 'pages#landing'

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  get "/expenses/:id/calendar", to: "expenses#calendar"


end
