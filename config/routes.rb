Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  # Defines the root path route ("/")
  root "modbus#index"
  get "/modbus", to: "modbus#index"
  get "/api/get_map/:id", to: "api#get_map"

  resources :digitals
  resources :analogs
  resources :titles
  resources :gauges
  resources :product_tanks
  resources :tank_logs

  get "/map", to: "digitals#map"
  post "/api/login", to: "api#login"
  post "/api/get_list", to: "api#get_list"
  post "/api/post_list", to: "api#post_list"

end
