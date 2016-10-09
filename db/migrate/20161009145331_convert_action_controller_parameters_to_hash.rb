class ConvertActionControllerParametersToHash < ActiveRecord::Migration
  def up
    EventRule.all.each do |rule|
      rule.update_column(:filter, rule.filter.to_h)
    end
  end
end
