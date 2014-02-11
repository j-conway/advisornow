class RemoveDifferentDatesFromMeetings < ActiveRecord::Migration
  def change
  	remove_column :meetings, :requested_datetime, :datetime
    remove_column :meetings, :scheduled_datetime, :datetime
  end
end
