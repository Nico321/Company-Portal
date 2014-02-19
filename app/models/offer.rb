class Offer < ActiveRecord::Base
	belongs_to :customer, :class_name => "User"
	belongs_to :agent, :class_name => "User"
	belongs_to :assignment

	has_one :request

	has_many :notes
	has_many :positions

	validates :customer, :subject, :request, presence: true
	
	def self.search(search)
	  if search
	    where('subject LIKE ?', "%#{search}%")
	  else
	    scoped
	  end
	end
end
