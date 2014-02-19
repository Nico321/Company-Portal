class AddInvoiceIdToPositions < ActiveRecord::Migration
  def change
  	add_column :positions, :invoice_id, :integer
  end
end
