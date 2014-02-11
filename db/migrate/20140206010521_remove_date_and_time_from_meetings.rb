class RemoveDateAndTimeFromMeetings < ActiveRecord::Migration
  def change
    remove_column :meetings, :requested_date, :date
    remove_column :meetings, :requested_time, :time
    remove_column :meetings, :scheduled_date, :date
    remove_column :meetings, :scheduled_time, :time
  end
end
