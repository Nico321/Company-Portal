class Article < ActiveRecord::Base
	has_many :storages, through: :article_storage
	has_many :positions
end
