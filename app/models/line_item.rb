class LineItem < ActiveRecord::Base
  belongs_to :article
  belongs_to :cart
  validates :article, :cart, presence: true
  
  def total_price
  	article.price * quantity
  end
end
