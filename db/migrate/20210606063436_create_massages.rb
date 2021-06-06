class CreateMassages < ActiveRecord::Migration[5.2]
  def change
    create_table :massages do |t|
      t.integer :user_id
      t.integer :room_id
      t.text :message
      t.timestamps
    end
  end
end
