Rails.application.routes.draw do
  root "wing_orders#index"
  resources :wing_orders, only: [:index, :new, :create, :update, :edit]
end
