class Installation < ActiveRecord::Base
	belongs_to :customer, :class_name => "User"
	belongs_to :agent, :class_name => "User"
	belongs_to :invoice

	has_one :order

	has_many :notes

	validates :subject, :customer, :order, presence: true
end
