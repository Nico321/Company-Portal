class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :place

  has_many :bugreports
  has_many :businessprocesses

scope :online, lambda{ where("updated_at > ?", 10.minutes.ago) }
end
