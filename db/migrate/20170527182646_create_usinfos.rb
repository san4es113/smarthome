class CreateUsinfos < ActiveRecord::Migration
  def change
    create_table :usinfos do |t|
      t.string :username
      t.date :birthday
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
