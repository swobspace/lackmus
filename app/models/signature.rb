class Signature < ApplicationRecord
  include SignatureConcerns
  # -- associations
  has_many :events, foreign_key: :alert_signature_id, primary_key: :signature_id

  # -- configuration
  ACTIONS = ['drop', 'ignore', 'normal', 'alert']
  # -- validations and callbacks
  validates :signature_id, presence: true, uniqueness: true
  validates :signature_info, presence: true
  validates :action, :allow_blank => false,
            :inclusion => {
              in: Signature::ACTIONS,
              message: "Select one of #{Signature::ACTIONS.join(", ")}"
            }


end
