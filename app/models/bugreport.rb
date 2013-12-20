class Bugreport < ActiveRecord::Base
	belongs_to :creator, :class_name => "User"
	belongs_to :agent , :class_name => "User"
end
