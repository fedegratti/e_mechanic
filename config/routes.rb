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
  get '/repair_order_numbers' => 'repair_orders#get_numbers'
  get '/get_car_by_chassis_number/:chassis_number' => 'cars#get_by_chassis_number'
  get '/get_car_by_client_identification/:identification' => 'cars#get_by_client_identification'
  get '/import_data_from_ayax/:chassis_number'=>'repair_orders#import_from_ayax'
  #get '/repair_orders/' => 'repair_orders#index'
  post '/get_repair_orders_by_chassis_number' => 'repair_orders#get_by_chassis_number'
  post '/get_repair_orders_by_order_number' => 'repair_orders#get_by_order_number'

  post '/clients/get_by_name' => 'clients#get_by_name'
  post '/cars/get_by_identification' => 'cars#get_by_identification'
end
