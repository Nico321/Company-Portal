class Note < ActiveRecord::Base
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	belongs_to :request
	belongs_to :offer
	belongs_to :user
	belongs_to :bugreport
	belongs_to :assignment
	belongs_to :order
	belongs_to :installation
	belongs_to :invoice

	validates :user, presence: true
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
