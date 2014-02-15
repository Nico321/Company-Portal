class BugreportsChangeDatetimeToTimestamp < ActiveRecord::Migration
  def self.up
   change_column :bugreports, :closed, :timestamp
  end

  def self.down
   change_column :bugreports, :closed, :datetime
  end
end
