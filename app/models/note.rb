class Note < ActiveRecord::Base
	belongs_to :request
	belongs_to :offer
	belongs_to :user
	belongs_to :bugreport
	belongs_to :assignment
	belongs_to :order
	belongs_to :installation
	belongs_to :invoice

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
	:storage => :dropbox,
	:dropbox_credentials => Rails.root.join("config/dropbox.yml"),
	:dropbox_options => {
	:path =>  proc { |style| "company-portal/images/notes/#{id}/#{style}/#{id}_#{style}"}
	} 

	validates :user, presence: true
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
