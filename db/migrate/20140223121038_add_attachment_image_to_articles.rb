class AddAttachmentImageToArticles < ActiveRecord::Migration
  def self.up
  	remove_column :articles, :image
    change_table :articles do |t|
      t.attachment :image
    end
  end

  def self.down
  	add_column :articles, :image, :string
    drop_attached_file :articles, :image
  end
end
