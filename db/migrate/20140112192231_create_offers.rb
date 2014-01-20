class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :subject
      t.text :body
      t.decimal :installationprice, :default => 0
      t.date :publication
      t.integer :customer_id
      t.integer :agent_id
      t.integer :assignment_id

      t.timestamps
    end
  end
end
