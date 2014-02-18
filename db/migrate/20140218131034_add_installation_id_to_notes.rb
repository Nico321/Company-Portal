class AddInstallationIdToNotes < ActiveRecord::Migration
  def change
  	add_column :notes, :installation_id, :integer
  end
end
