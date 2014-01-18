class Position < ActiveRecord::Base
	belongs_to :article
	belongs_to :offer
	belongs_to :assignment

	validates :article, :offer, :quantity, presence: true
end
