class AddMeetingDatetimeToMeeting < ActiveRecord::Migration
  def change
    add_column :meetings, :meeting_datetime, :datetime
  end
end
