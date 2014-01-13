class Note < ActiveRecord::Base
	belongs_to :request
	belongs_to :offer
	belongs_to :user

	validates :user, presence: true
end
