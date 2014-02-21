class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :name
      t.text :image
      t.decimal :price, precision: 8, scale: 2
      t.integer :delivertime
      t.integer :supplierid

      t.timestamps
    end
  end
end
