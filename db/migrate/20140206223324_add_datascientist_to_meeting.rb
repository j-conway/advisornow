class AddDatascientistToMeeting < ActiveRecord::Migration
  def change
    add_column :meetings, :datascientist_id, :integer
  end
end
