class CreateBugreports < ActiveRecord::Migration
  def change
    create_table :bugreports do |t|
      t.string :subject
      t.text :description
      t.integer :reporter_id
      t.integer :agent_id
      t.date :closed

      t.timestamps
    end
  end
end
