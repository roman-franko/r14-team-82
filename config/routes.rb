Rails.application.routes.draw do
  resources :requests, only: [:create, :index, :show]

  root  'dashboard#index'

end
