class RemoveLengthsFromMeetings < ActiveRecord::Migration
  def change
  	remove_column :meetings, :requested_length, :decimal
    remove_column :meetings, :scheduled_length, :decimal
  end
end
