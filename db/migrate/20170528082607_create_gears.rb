class CreateGears < ActiveRecord::Migration
  def change
    create_table :gears do |t|
      t.string :title
      t.string :definitionkey
      t.integer :usinfo_id
      t.float :latitude
      t.float :longitude
      t.string :address
      t.text :description

      t.timestamps null: false
    end
  end
end
