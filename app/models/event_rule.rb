class EventRule < ActiveRecord::Base
  # include EventRuleConcerns
  # -- associations
  # -- configuration
  serialize :filter, Hash
  ACTIONS = ['drop', 'ignore', 'investigate', 'alert']

  acts_as_list

  # -- validations and callbacks
  validates :filter, presence: true
  validates :action, :allow_blank => false,
            :inclusion => {
              in: EventRule::ACTIONS,
              message: "Select one of #{Signature::ACTIONS.join(", ")}"
            }

end
