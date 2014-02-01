class AddStatusToConsults < ActiveRecord::Migration
  def change
    add_column :consults, :status, :string
  end
end
