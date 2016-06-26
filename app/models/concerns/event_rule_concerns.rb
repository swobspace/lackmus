module EventRuleConcerns
  extend ActiveSupport::Concern

  included do
    scope :active, -> {
      where(["action NOT IN (?)", ['drop', 'ignore']])
    }
  end

  class_methods do
  end

  def ar_filter
    filter.slice(*EventRule::FILTER_ATTRIBUTES).symbolize_keys
  end
end

