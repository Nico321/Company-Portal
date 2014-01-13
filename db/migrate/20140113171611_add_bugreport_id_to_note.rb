class AddBugreportIdToNote < ActiveRecord::Migration
  def change
    add_column :notes, :bugreport_id, :integer
  end
end
