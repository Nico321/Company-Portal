class Note < ActiveRecord::Base
	belongs_to :request
	belongs_to :offer
	belongs_to :user
	belongs_to :bugreport
	belongs_to :assignment
	belongs_to :order

	validates :user, presence: true
end
