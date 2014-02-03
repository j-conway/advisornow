class AddFieldsToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :requested_time, :time
    add_column :meetings, :scheduled_time, :time
    add_column :meetings, :requested_date, :date
    add_column :meetings, :scheduled_date, :date
    add_column :meetings, :requested_length, :decimal
    add_column :meetings, :scheduled_length, :decimal
  end
end
