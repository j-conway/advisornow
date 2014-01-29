class CreateConsults < ActiveRecord::Migration
  def change
    create_table :consults do |t|
      t.integer :creator_id
      t.integer :customer_id
      t.integer :datascientist_id
      t.string :subject

      t.timestamps
    end
  end
end
