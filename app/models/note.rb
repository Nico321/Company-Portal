class Note < ActiveRecord::Base
	belongs_to :request
	belongs_to :offer
	belongs_to :user
	belongs_to :bugreport
	belongs_to :assignment

	validates :user, presence: true
end
