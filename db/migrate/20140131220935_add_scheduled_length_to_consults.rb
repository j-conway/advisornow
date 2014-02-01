class AddScheduledLengthToConsults < ActiveRecord::Migration
  def change
    add_column :consults, :scheduled_length, :integer
  end
end
