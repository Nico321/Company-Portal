class User < ActiveRecord::Base
  rolify
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :bugreports

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
  :default_url => '/images/defaultimage_:style.png',
  :storage => :dropbox,
  :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
  :dropbox_options => {
    :path =>  proc { |style| "company-portal/images/users/#{id}/#{style}/#{id}_#{style}"},
  }
  
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates :firstname, :lastname, :phone, :street, :zip, presence: true

scope :online, lambda{ where("updated_at > ?", 10.minutes.ago) }
end