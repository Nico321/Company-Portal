class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :article, index: true
      t.belongs_to :cart, index: true
      t.integer :line_items, :quantity, default: 1

      t.timestamps
    end
  end
end
