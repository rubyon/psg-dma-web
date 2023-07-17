Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  # Defines the root path route ("/")
  root "modbus#index"
  get "/modbus", to: "modbus#index"
  get "/api/get_map/:id", to: "api#get_map"

  resources :digitals

  get "/map", to: "digitals#map"

end
