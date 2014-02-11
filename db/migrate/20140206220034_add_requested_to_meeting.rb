class AddRequestedToMeeting < ActiveRecord::Migration
  def change
    add_column :meetings, :requested, :boolean
  end
end
