Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    resources :sessions, only: [:create]
    resources :users, only: [:show, :create, :update, :destroy]
    resources :practitioners do
      resources :availabilities
    end
    resources :patients do
      resources :bookings, except: [:index, :destroy, :show]
    end
    resources :bookings, only: [:show]
  end
end
