class AddOrderIdToNote < ActiveRecord::Migration
  def change
  	add_column :notes, :order_id, :integer
  end
end
