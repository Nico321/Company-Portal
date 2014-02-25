class User < ActiveRecord::Base
  rolify
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :place

  has_many :bugreports

	def self.search(search)
	  if search
	    where('firstname LIKE ?', search)
	  else
	    all
	  end
	end

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/avatarIsNil.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

scope :online, lambda{ where("updated_at > ?", 10.minutes.ago) }
end
