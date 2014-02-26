class Article < ActiveRecord::Base
	has_many :storages, through: :article_storage
	has_many :positions
	has_many :line_items
	has_many :carts, through: :line_items
	before_destroy :ensure_not_referenced_by_any_line_item

	has_attached_file :image, :styles => {:medium => "300x300>", :mini => "70x60>"},
	:default_url => '/images/defaultimage_:style.png',
	:storage => :dropbox,
	:dropbox_credentials => Rails.root.join("config/dropbox.yml"),
	:dropbox_options => {
		:path =>  proc { |style| "company-portal/images/articles/#{id}/#{style}/#{id}_#{style}"},
	} 
	validates_attachment_content_type :image, :content_type => /^image\/(png|gif|jpg|jpeg)/

	validates :name, :description, presence: true
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	validates :name, uniqueness: true 

	def self.latest
		Article.order{:updatet_at}.last 
	end

	private

	def ensure_not_referenced_by_any_line_item
		if line_items.empty?
			return true
		else
			errors.add(:base, 'There are referenced line items left!')
			return false
		end 
	end

end
