class EventRule < ActiveRecord::Base
  # include EventRuleConcerns
  # -- associations
  # -- configuration
  serialize :filter, Hash
  ACTIONS = ['drop', 'ignore', 'investigate', 'alert']

  FILTER_ATTRIBUTES = [ 'src_ip', 'src_port', 'dst_ip', 'dst_port',
                        'signature_id' ]

  acts_as_list

  # -- validations and callbacks
  validates :filter, presence: true
  validates :action, :allow_blank => false,
            :inclusion => {
              in: EventRule::ACTIONS,
              message: "Select one of #{Signature::ACTIONS.join(", ")}"
            }

end
