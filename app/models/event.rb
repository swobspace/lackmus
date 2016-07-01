class Event < ActiveRecord::Base
  include EventConcerns
  # -- associations
  belongs_to :signature, counter_cache: true,
             foreign_key: :alert_signature_id,
             primary_key: :signature_id
  belongs_to :event_rule

  # -- configuration
  alias_attribute :dest_ip, :dst_ip
  alias_attribute :dest_port, :dst_port
  alias_attribute :timestamp, :event_time

  # -- validations and callbacks
  before_save :import_signature
  before_save :assign_filter if :event_rule_id.nil?

  validates :sensor, :event_time, :src_ip, :dst_ip, :proto, presence: true

  # create a new signature from event data
  # if alert_signature_id and alert_signature are available
  # and signature does not yet exist
  def import_signature
    return true unless (alert_signature_id.present? && alert_signature.present?)
    sig = Signature.find_or_create_by(signature_id: alert_signature_id) do |sig|
      sig.signature_info = alert_signature
      sig.action         = 'normal'
      sig.category	 = alert_category
      sig.severity	 = alert_severity
    end
    unless sig.category.blank?
      sig.update_attributes(category: alert_category, severity: alert_severity)
    end
    if sig.persisted?
      true
    else
      errors.add(:base, 'could not create signature from event')
      false
    end
  end

end
