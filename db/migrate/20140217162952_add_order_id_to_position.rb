class AddOrderIdToPosition < ActiveRecord::Migration
  def change
  	add_column :positions, :order_id, :integer
  end
end
