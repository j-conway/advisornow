class AddMeetingLengthToMeeting < ActiveRecord::Migration
  def change
    add_column :meetings, :meeting_length, :decimal
  end
end
