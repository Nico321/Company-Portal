class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :zip, :limit => 5
      t.string :name

      t.timestamps
    end
  end
end
