class RemoveSupplierIdFromArticles < ActiveRecord::Migration
  def self.up
  	remove_column :articles, :supplier_id, :integer
  end

  def self.down
  	add_column :articles, :supplier_id, :integer
  end
end
