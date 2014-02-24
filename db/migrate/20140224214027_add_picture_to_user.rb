class AddPictureToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.image :image
    end
  end

  def self.down
    drop_column :image
  end
end
