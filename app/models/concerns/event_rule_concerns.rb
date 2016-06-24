module EventRuleConcerns
  extend ActiveSupport::Concern

  included do
  end

  class_methods do
  end

  def ar_filter
    filter.slice(*EventRule::FILTER_ATTRIBUTES).symbolize_keys
  end
end

