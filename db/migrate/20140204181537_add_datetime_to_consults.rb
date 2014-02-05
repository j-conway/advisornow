class AddDatetimeToConsults < ActiveRecord::Migration
  def change
    add_column :consults, :requested_datetime, :datetime
    remove_column :consults, :requested_date, :date
    remove_column :consults, :requested_time, :time
  end
end
