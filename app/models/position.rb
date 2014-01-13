class Position < ActiveRecord::Base
	belongs_to :article
	belongs_to :offer

	validates :article, :offer, :quantity, presence: true
end
