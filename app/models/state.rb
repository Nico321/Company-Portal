class State < ActiveRecord::Base
	has_many :businessprocesses
	has_many :notes
end
