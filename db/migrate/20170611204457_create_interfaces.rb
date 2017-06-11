class CreateInterfaces < ActiveRecord::Migration
  def change
    create_table :interfaces do |t|
      t.integer :state
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
