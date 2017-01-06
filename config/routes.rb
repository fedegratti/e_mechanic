Rails.application.routes.draw do
  resources :repair_orders
  resources :manuals
  resources :technical_reports
  resources :cars
  resources :clients
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
