class Order < ActiveRecord::Base
	belongs_to :customer, :class_name => "User"
	belongs_to :agent, :class_name => "User"
	belongs_to :installation

	has_one :assignment

	has_many :notes
	has_many :positions

	validates :subject, :customer, presence: true
	
	def self.search(search)
	  if search
	    where('subject LIKE ?', "%#{search}%")
	  else
	    all
	  end
	end
end
