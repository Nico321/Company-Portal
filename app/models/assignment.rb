class Assignment < ActiveRecord::Base
	belongs_to :customer, :class_name => "User"
	belongs_to :agent, :class_name => "User"
	belongs_to :order

	has_one :offer

	has_many :notes
	has_many :positions

	validates :subject, :customer, :offer, presence: true
end
