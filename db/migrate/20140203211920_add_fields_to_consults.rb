class AddFieldsToConsults < ActiveRecord::Migration
  def change
    add_column :consults, :requested_time, :time
    add_column :consults, :requested_date, :date
    add_column :consults, :requested_length, :decimal
  end
end
