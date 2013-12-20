class Businessprocess < ActiveRecord::Base
	belongs_to :customer, :class_name => "User"
	belongs_to :agent, :class_name => "User"
	belongs_to :state

	has_many :notes
	has_many :positions
end
