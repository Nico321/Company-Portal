class LineItemsController < ApplicationController
	include CurrentCart
	before_action :set_cart, only: [:destroy, :create, :decrement]
	before_action :set_line_item, only: [:show, :edit, :update, :destroy]

	def create
		article = Article.find(params[:article_id])
		@line_item = @cart.add_article(article.id)

		respond_to do |format|
			if @line_item.save
				format.html { redirect_to @line_item.cart}
				format.json { render action:'show',
				  status: :created, location: @line_item }
			else
				format.html { render action: 'new'}
				format.json { render json: @line_item.errors,
					status: :unprocessable_entity}
			end	
		end	
	end

	def destroy
		@line_item.destroy
		respond_to do |format|
			if @line_item.cart.line_items.empty?
				format.html {redirect_to(store_url, :notice => "Your cart is empty")}	
			else
				format.html {redirect_to(@cart, :notice => "Item Removed")}
			end
 			
  		end
    end

    def decrement
    	@line_item = LineItem.find(params[:line_item_id])
    	@line_item= @cart.remove_article(@line_item.article_id)  
	    respond_to do |format|
			if @line_item.cart.line_items.empty?
				format.html {redirect_to(store_url, :notice => "Your cart is empty")}	
			else
				format.html {redirect_to(@cart, :notice => "Item Removed")}
			end	
  		end
    end

	private 

	def set_line_item
		@line_item = LineItem.find(params[:id])
	end

	def line_item_params
		params.require(:line_item).permit(:article_id)
	end

end
