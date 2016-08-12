Rails.application.routes.draw do
  resources :main_searches, only: [:new, :create, :show]

  get 'host_reports/show', 
        controller: :host_reports, action: :show,
        as: :show_host_report

  get 'host_reports/mail/new', 
        controller: :host_reports, action: :new_mail,
        as: :new_mail_host_report

  post 'host_reports/mail', 
        controller: :host_reports, action: :create_mail,
        as: :create_mail_host_report

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
