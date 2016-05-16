Rails.application.routes.draw do
  resources :events
  mount Wobauth::Engine, at: '/auth'

  root 'events#index'
end
