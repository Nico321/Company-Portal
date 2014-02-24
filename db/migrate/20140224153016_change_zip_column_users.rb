class ChangeZipColumnUsers < ActiveRecord::Migration
  def change
  def self.up
   change_column :users, :zip, :string, :limit => nil
  end

  def self.down
   change_column :users, :zip, :string, :limit => 5
  end
  end
end
