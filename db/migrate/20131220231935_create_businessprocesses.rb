class CreateBusinessprocesses < ActiveRecord::Migration
  def change
    create_table :businessprocesses do |t|
      t.integer :customerid
      t.string :subject
      t.text :request
      t.integer :employeeid
      t.integer :urgency
      t.integer :stateid
      t.decimal :discount
      t.text :offer
      t.decimal :installationprice

      t.timestamps
    end
  end
end
