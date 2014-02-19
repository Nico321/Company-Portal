class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :subject
      t.text :body
      t.integer :installation_id
      t.integer :agent_id
      t.integer :customer_id
      t.decimal :installationprice
      t.datetime :payed

      t.timestamps
    end
  end
end
