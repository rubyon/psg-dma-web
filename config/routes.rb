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
  post "/mobile/account/login", to: "api#login"
  post "/relic/mobile/tag/findLocCodeList.json", to: "api#get_location"
  post "/relic/mobile/tag/findLocTagList.json", to: "api#get_list"
  post "/mobile/relic/addModSurvey", to: "api#post_list"

end
