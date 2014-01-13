class Bugreport < ActiveRecord::Base
	belongs_to :reporter, :class_name => "User"
	belongs_to :agent , :class_name => "User"

	validates :reporter, :subject, :description, presence: true
end
