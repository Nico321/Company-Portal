class Request < ActiveRecord::Base
	belongs_to :customer, :class_name => "User"
	belongs_to :agent, :class_name => "User"
	belongs_to :offer

	has_many :notes

	validates :subject, :body, :customer, :urgency, presence: true
	
	def self.search(search)
	  if search
	    where('subject LIKE ?', "%#{search}%")
	  else
	    all
	  end
	end
end