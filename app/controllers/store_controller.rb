class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart
  
  def index
  	@articles = Article.order(:name)
  end
end
