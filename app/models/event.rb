class Event < ApplicationRecord
  include EventConcerns
  # -- associations
  belongs_to :signature, counter_cache: true, optional: true,
             foreign_key: :alert_signature_id,
             primary_key: :signature_id
  belongs_to :event_rule, optional: true

  # -- configuration
  alias_attribute :dest_ip, :dst_ip
  alias_attribute :dest_port, :dst_port
  alias_attribute :timestamp, :event_time

  # -- validations and callbacks
  validates :sensor, :event_time, :src_ip, :dst_ip, :proto, presence: true

end
