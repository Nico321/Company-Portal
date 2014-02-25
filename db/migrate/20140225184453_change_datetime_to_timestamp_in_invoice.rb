class ChangeDatetimeToTimestampInInvoice < ActiveRecord::Migration
  def change
  def self.up
   change_column :invoices, :payed, :timestamp
  end

  def self.down
   change_column :invoices, :payed, :datetime
  end
  end
end
