class Note < ActiveRecord::Base
	belongs_to :businessprocess
	belongs_to :state
end
