class AddAssignmentIdToPosition < ActiveRecord::Migration
  def change
  	add_column :positions, :assignment_id, :integer
  end
end
