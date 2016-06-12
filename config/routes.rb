Rails.application.routes.draw do
  resources :signatures do
    member do
      get 'pcap'
      delete 'destroy_events'
    end
  end
  resources :events do
    member do
      get 'packet'
    end
  end

  mount Wobauth::Engine, at: '/'

  root 'events#index'
end
