class Storage < ActiveRecord::Base
	has_many :articles, through: :article_storage
	belongs_to :place
end
