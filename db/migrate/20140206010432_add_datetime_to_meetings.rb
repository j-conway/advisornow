class AddDatetimeToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :requested_datetime, :datetime
    add_column :meetings, :scheduled_datetime, :datetime
  end
end
