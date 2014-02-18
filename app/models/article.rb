class Article < ActiveRecord::Base
	has_many :storages, through: :article_storage
	has_many :positions

	# Validations including error messages
	# ToDo add :image
	validates :name, :description, :presence => {:message => "cannot be blank, Task not saved"}
	# ToDo validates :image, format: { with: %r {\.(gif|jpg|png)$}i,  message: "must be a URL for a GIF, JPG, or PNG image" }
	validates :price, numericality: {greater_than_or_equal_to: 0.01}

end
