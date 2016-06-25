Rails.application.routes.draw do
  resources :event_rules
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

  root 'signatures#index', filter: 'current'
end
