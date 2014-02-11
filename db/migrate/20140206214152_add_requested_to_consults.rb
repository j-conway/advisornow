class AddRequestedToConsults < ActiveRecord::Migration
  def change
    add_column :consults, :requested, :boolean
  end
end
