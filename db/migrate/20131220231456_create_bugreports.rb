class CreateBugreports < ActiveRecord::Migration
  def change
    create_table :bugreports do |t|
      t.string :subject
      t.text :description
      t.integer :userid
      t.integer :employeeid

      t.timestamps
    end
  end
end
