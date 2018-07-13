FactoryBot.define do

  sequence :mailaddr do |n|
    "recipient_#{n}@example.org"
  end

  sequence :number do |num|
    num
  end

  factory :event do
    event_time Time.now
    sensor "bordergate"
    src_ip "192.0.2.199"
    dst_ip "192.0.2.201"
    proto "TCP"
  end

  factory :event_rule do
    filter {{ src_ip: "192.0.2.199", signature: 1234 }}
    action "investigate"
  end


  factory :signature do
    signature_id { generate(:number) }
    signature_info "brabbelfaselblub"
    action "normal"
  end

  factory :systemevent, class: Syslog::Systemevent do
    fromhost "FromHost"
  end

end

