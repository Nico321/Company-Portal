class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :subject
      t.text :body
      t.integer :urgency
      t.integer :customer_id
      t.integer :agent_id
      t.integer :offer_id

      t.timestamps
    end
  end
end
