class AddInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone_number, :string
    add_column :users, :alpine_user, :boolean, default: false
    add_column :users, :company_admin, :boolean, default: false
    add_column :users, :entitled, :boolean, default: false
  end
end
