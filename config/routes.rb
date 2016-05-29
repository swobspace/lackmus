Rails.application.routes.draw do
  resources :signatures do
    member do
      get 'pcap'
    end
  end
  resources :events do
    member do
      get 'packet'
    end
  end

  mount Wobauth::Engine, at: '/auth'

  root 'events#index'
end
