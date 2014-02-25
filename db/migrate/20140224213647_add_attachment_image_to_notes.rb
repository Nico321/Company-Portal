class AddAttachmentImageToNotes < ActiveRecord::Migration
  def self.up
  	remove_column :notes, :imageurl
    change_table :notes do |t|
      t.attachment :image
    end
  end

  def self.down
  	add_column :articles, :image, :string
    drop_attached_file :notes, :image
  end
end
