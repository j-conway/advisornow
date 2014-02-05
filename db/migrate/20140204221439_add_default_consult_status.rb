class AddDefaultConsultStatus < ActiveRecord::Migration
  def change
    change_column :consults, :status, :string, :default => "Open"
  end
end
