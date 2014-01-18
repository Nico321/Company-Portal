class AddAssignmentIdToNote < ActiveRecord::Migration
  def change
  	add_column :notes, :assignment_id, :integer
  end
end
