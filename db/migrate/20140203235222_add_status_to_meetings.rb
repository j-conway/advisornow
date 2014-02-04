class AddStatusToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :status, :string
  end
end
