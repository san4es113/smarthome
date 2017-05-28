class CreateMakes < ActiveRecord::Migration
  def change
    create_table :makes do |t|
      t.string :property
      t.string :state
      t.integer :gear_id
      t.datetime :update_date

      t.timestamps null: false
    end
  end
end
