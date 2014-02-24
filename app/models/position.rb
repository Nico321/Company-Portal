class Position < ActiveRecord::Base
	belongs_to :article
	belongs_to :offer
	belongs_to :assignment
	belongs_to :invoice

	#ToDo add assignment presence validation because you can't add
	# a position to an assignment that doesn't exist!
	belongs_to :order

	validates :article, :quantity, :offer, presence: true
end
