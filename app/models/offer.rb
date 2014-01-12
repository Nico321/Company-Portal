class Offer < ActiveRecord::Base
	belongs_to :customer, :class_name => "User"
	belongs_to :agent, :class_name => "User"
	belongs_to :order

	has_one :request

	has_many :notes
	has_many :positions

	validates :customer, :subject, :request, presence: true
end
