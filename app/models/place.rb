class Place < ActiveRecord::Base
	has_many :users
	has_many :storages
	has_many :suppliers
end
