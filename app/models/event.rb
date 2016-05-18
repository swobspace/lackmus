class Event < ActiveRecord::Base
  include EventConcerns
  # -- associations
  # -- configuration
  # -- validations and callbacks
  validates :sensor, :event_time, :src_ip, :dst_ip, :proto, presence: true

end
