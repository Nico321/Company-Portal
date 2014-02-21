class Article < ActiveRecord::Base
	has_many :storages, through: :article_storage
	has_many :positions
	has_many :line_items
	before_destroy :ensure_not_referenced_by_any_line_item

	validates :name, :description, :image, presence: true
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	validates :name, uniqueness: true
	validates :image, allow_blank: true, format: {
		with: %r{\.(gif|jpg|png)\Z}i,
		message: 'must be a URL for GIF,JPG or PNG image.'
	}

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
