class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :subject
      t.text :body
      t.integer :stateid
      t.text :imageurl
      t.integer :businessprocessid

      t.timestamps
    end
  end
end
