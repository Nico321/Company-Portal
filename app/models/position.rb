class Position < ActiveRecord::Base
	belongs_to :article
	belongs_to :offer
	belongs_to :assignment
	#ToDo add assignment presence validation because you can't add
	# a position to an assignment that doesn't exist!
	validates :article, :offer, :quantity, presence: true
end
