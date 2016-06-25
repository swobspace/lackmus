class SetEventsCountDefault < ActiveRecord::Migration
  def up
    change_column_default :signatures, :events_count, 0

    Signature.where(events_count: nil).update_all(events_count: 0)
  end

  def down
  end
end
