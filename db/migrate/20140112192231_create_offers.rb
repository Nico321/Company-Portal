class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :subject
      t.text :body
      t.decimal :installationprice
      t.date :publication
      t.integer :customer_id
      t.integer :agent_id
      t.integer :order_id

      t.timestamps
    end
  end
end
