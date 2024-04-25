Rails.application.routes.draw do
  resources :tickets, only: [:index, :update, :show] do
     get 'cost', on: :collection
  end
  resources :bookings, only: [:create, :destroy]
  resources :purchases, only: [:create]
 end
