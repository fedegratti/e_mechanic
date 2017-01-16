Rails.application.routes.draw do
  resources :mechanics
  resources :countries
  resources :states
  resources :cities
  resources :repair_orders
  resources :manuals
  resources :technical_reports
  resources :cars
  resources :clients
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'repair_orders#index'

  get '/chassis_numbers' => 'cars#get_chassis_numbers'
  get '/cis' => 'clients#get_cis'
  get '/get_car_by_chassis_number/:chassis_number' => 'cars#get_by_chassis_number'
  get '/get_car_by_client_identification/:identification' => 'cars#get_by_client_identification'
  get '/read_xls/:chassis_number'=>'repair_orders#read_xls'
end
