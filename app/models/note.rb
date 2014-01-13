class Note < ActiveRecord::Base
	belongs_to :request
	belongs_to :offer
	belongs_to :user
	belongs_to :bugreport

	validates :user, presence: true
end
