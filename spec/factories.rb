FactoryGirl.define do

  sequence :mailaddr do |n|
    "recipient_#{n}@example.org"
  end

  sequence :aname do |n|
    "name_#{n}"
  end

  sequence :number do |num|
    num
  end

  factory :event do
    event_time Time.now
    sensor "bordergate"
    src_ip "1.2.3.4"
    dst_ip "5.6.7.8"
    proto "TCP"
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

