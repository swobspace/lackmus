class Event < ActiveRecord::Base
  include EventConcerns
  # -- associations
  # -- configuration
  alias_attribute :dest_ip, :dst_ip
  alias_attribute :dest_port, :dst_port
  alias_attribute :timestamp, :event_time

  # -- validations and callbacks
  validates :sensor, :event_time, :src_ip, :dst_ip, :proto, presence: true

end
