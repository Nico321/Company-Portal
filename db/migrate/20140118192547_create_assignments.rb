class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :subject
      t.text :body
      t.decimal :installationprice
      t.integer :customer_id
      t.integer :agent_id
      t.integer :order_id

      t.timestamps
    end
  end
end
