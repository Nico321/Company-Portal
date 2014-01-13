class AddOfferToNote < ActiveRecord::Migration
  def change
    add_column :notes, :offer_id, :integer
  end
end
