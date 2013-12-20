class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :street
      t.string :zip, :limit => 5
      t.string :email
      t.string :phone
      t.string :url

      t.timestamps
    end
  end
end
