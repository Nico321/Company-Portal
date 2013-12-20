class CreateStorages < ActiveRecord::Migration
  def change
    create_table :storages do |t|
      t.string :name
      t.string :street
      t.string :zip, :limit => 5

      t.timestamps
    end
  end
end
