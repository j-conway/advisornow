class AddScheduledDatetimeToConsults < ActiveRecord::Migration
  def change
    add_column :consults, :scheduled_datetime, :datetime
  end
end
