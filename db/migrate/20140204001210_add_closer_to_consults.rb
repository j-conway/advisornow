class AddCloserToConsults < ActiveRecord::Migration
  def change
    add_column :consults, :closer_id, :integer
  end
end
