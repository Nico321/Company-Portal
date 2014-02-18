class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :subject
      t.text :body
      t.decimal :installationprice
      t.integer :customer_id
      t.integer :agent_id
      t.integer :installation_id

      t.timestamps
    end
  end
end
