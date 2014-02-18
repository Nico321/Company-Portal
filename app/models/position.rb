class Position < ActiveRecord::Base
	belongs_to :article
	belongs_to :offer
	belongs_to :assignment
	belongs_to :order

	validates :article, :offer, :quantity, presence: true
end
