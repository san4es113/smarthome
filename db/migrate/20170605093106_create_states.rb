class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :property
      t.string :state
      t.string :update
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
