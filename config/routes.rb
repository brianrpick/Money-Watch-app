Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # creates restful routs for you (CRUD)
  resources :users, :expenses, :transactions
  get '/', to: 'users#home'
end
