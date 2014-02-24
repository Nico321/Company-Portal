class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart
  
  def index
  	@articles = Article.order(:name).paginate(:per_page => 10, :page => params[:page])
  end
end
