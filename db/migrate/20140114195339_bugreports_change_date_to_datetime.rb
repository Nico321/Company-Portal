class BugreportsChangeDateToDatetime < ActiveRecord::Migration
  def self.up
   change_column :bugreports, :closed, :datetime
  end

  def self.down
   change_column :bugreports, :closed, :date
  end
end
