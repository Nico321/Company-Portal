class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.references :article, index: true
      t.references :businessprocess, index: true
      t.integer :quantity
      t.date :deliverydate

      t.timestamps
    end
  end
end
