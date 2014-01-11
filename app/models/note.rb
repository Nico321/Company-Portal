class Note < ActiveRecord::Base
	belongs_to :request
	belongs_to :user

	validates :request, :user, presence: true
end
