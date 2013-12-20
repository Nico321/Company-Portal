class Supplier < ActiveRecord::Base
	belongs_to :place

	has_many :articles
end
