FactoryGirl.define do

  sequence :mailaddr do |n|
    "recipient_#{n}@example.org"
  end

  sequence :aname do |n|
    "name_#{n}"
  end

  factory :event do
    event_time Time.now
    sensor "bordergate"
    src_ip "1.2.3.4"
    dst_ip "5.6.7.8"
    proto "TCP"
  end

end

