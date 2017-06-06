class CreateSpectatings < ActiveRecord::Migration
  def change
    create_table :spectatings do |t|
      t.float :latitude
      t.float :longitude
      t.string :address
      t.string :title
      t.text :description
      t.string :content
      t.datetime :date

      t.timestamps null: false
    end
  end
end
