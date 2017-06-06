class AddAttachmentImageToSpectatings < ActiveRecord::Migration
  def self.up
    change_table :spectatings do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :spectatings, :image
  end
end
