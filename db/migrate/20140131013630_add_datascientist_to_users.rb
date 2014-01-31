class AddDatascientistToUsers < ActiveRecord::Migration
  def change
    add_column :users, :datascientist, :boolean
  end
end
