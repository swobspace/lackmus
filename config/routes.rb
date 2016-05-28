Rails.application.routes.draw do
  resources :signatures
  resources :events do
    member do
      get 'packet'
    end
  end

  mount Wobauth::Engine, at: '/auth'

  root 'events#index'
end
