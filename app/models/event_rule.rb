class EventRule < ActiveRecord::Base
  # include EventRuleConcerns
  # -- associations
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
  validates :filter, presence: true
  validates :action, :allow_blank => false,
            :inclusion => {
              in: EventRule::ACTIONS,
              message: "Select one of #{Signature::ACTIONS.join(", ")}"
            }

end
