class CreateConsultMemberships < ActiveRecord::Migration
  def change
    create_table :consult_memberships do |t|
      t.integer :user_id
      t.integer :consult_id

      t.timestamps
    end
  end
end
