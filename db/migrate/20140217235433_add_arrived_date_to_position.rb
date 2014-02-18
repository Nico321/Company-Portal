class AddArrivedDateToPosition < ActiveRecord::Migration
  def change
  	add_column :positions, :arrived, :datetime
  end
end
