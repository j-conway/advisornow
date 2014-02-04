class AddRequesterToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :requester_id, :integer
  end
end
