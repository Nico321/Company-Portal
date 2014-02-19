class AddInvoiceIdToNotes < ActiveRecord::Migration
  def change
  	add_column :notes, :invoice_id, :integer
  end
end
