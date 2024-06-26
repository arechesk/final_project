Rails.application.routes.draw do
  get 'tickets/cost', to: 'tickets#cost'
  get 'tickets/check_availability', to: 'tickets#check_availability'

  resources :tickets, only: %i[index update show]
end
