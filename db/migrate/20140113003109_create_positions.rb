class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.integer :quantity, :default => 1
      t.date :deliverydate
      t.integer :article_id
      t.integer :offer_id

      t.timestamps
    end
  end
end
