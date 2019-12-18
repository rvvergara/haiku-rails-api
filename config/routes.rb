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
    get 'activate/:id', to: 'account_activations#activate', as: 'account_activation'
    put 'bookings/:id/confirm', to: 'bookings#confirm', as: 'booking_confirm'
    
    put 'bookings/:id/reject', to: 'bookings#reject', as: 'booking_reject'

    put 'bookings/:id/cancel', to: 'bookings#cancel', as: 'booking_cancel'
  end
end
