module SignatureConcerns
  extend ActiveSupport::Concern

  included do
    scope :active, -> { 
      where(["events_count > 0 AND action NOT IN (?)", ['drop', 'ignore']])
    }
    scope :current, -> { where("events_count > 0") }
    scope :ignored, -> { where(["action IN (?)", ['drop', 'ignore']]) }
  end

end

