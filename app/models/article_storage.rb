class ArticleStorage < ActiveRecord::Base
  belongs_to :article
  belongs_to :storage
end
