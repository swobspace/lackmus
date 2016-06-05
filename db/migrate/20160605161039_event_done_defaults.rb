class EventDoneDefaults < ActiveRecord::Migration
  def change
    change_column_default :events, :done, false
    change_column_default :events, :ignore, false
    Event.where("done is NULL").update_all(done: false)
    Event.where("ignore is NULL").update_all(ignore: false)
  end
end
