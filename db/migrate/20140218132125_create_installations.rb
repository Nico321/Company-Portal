class CreateInstallations < ActiveRecord::Migration
  def change
    create_table :installations do |t|
      t.string :subject
      t.text :body
      t.date :installationdate
      t.integer :invoice_id
      t.integer :order_id
      t.integer :customer_id
      t.integer :agent_id

      t.timestamps
    end
  end
end
