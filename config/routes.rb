Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    resources :sessions, only: [:create]
    resources :users, only: [:show, :create, :update, :destroy]
    resources :practitioners do
      resources :availabilities
      resources :bookings, module: :practitioners, only: [:create]
    end
    resources :patients do
      resources :bookings, except: [:destroy, :show, :index]
    end
    resources :bookings, only: [:show, :index]
  end
end
