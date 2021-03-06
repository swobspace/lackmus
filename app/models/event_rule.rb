class EventRule < ApplicationRecord
  include EventRuleConcerns
  # -- associations
  has_many :events, dependent: :nullify
  # -- configuration
  serialize :filter, Hash
  ACTIONS = [
    'drop', 'ignore', 'investigate', 'alert'
  ]

  FILTER_ATTRIBUTES = [ 
    'sensor', 'src_ip', 'src_port', 'dst_ip', 'dst_port', 'proto',
    'alert_signature_id', 'alert_category', 'alert_severity',
    'http_hostname', 'http_xff', 'http_content_type', 'http_status',
    'http_protocol', 'http_method'
  ]

  acts_as_list

  # -- validations and callbacks
  before_validation :remove_empty_filter_attributes
  validates :filter, presence: true
  validates :action, :allow_blank => false,
            :inclusion => {
              in: EventRule::ACTIONS,
              message: "Select one of #{EventRule::ACTIONS.join(", ")}"
            }

private

  def remove_empty_filter_attributes
    return true if filter.blank?
    self[:filter] = filter.reject{|_, v| v.blank?}
  end

end
