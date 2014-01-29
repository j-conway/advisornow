class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.integer :consult_id
      t.string :description

      t.timestamps
    end
  end
end
