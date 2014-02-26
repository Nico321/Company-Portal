class RemoveSupplierIdFromArticles < ActiveRecord::Migration
  def self.up
  	remove_column :articles, :supplierid, :integer
  end

  def self.down
  	add_column :articles, :supplierid, :integer
  end
end
