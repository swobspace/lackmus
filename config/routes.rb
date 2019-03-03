Rails.application.routes.draw do
  resources :main_searches, only: [:new, :create]

  get 'main_searches/show', 
        controller: :main_searches, action: :show,
        as: :show_main_search

  get 'host_reports/show', 
        controller: :host_reports, action: :show,
        as: :show_host_report

  get 'host_reports/mail/new', 
        controller: :host_reports, action: :new_mail,
        as: :new_mail_host_report

  post 'host_reports/mail', 
        controller: :host_reports, action: :create_mail,
        as: :create_mail_host_report

  post 'host_reports/update', 
        controller: :host_reports, action: :update,
        as: :update_host_report

  resources :event_rules
  resources :signatures do
    member do
      get 'pcap'
      delete 'destroy_events'
    end
  end
  resources :events, except: [:new, :create] do
    member do
      get 'packet'
    end
  end

  mount Wobauth::Engine, at: '/auth'

  root 'signatures#index', filter: 'current'
end
