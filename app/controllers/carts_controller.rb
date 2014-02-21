class CartsController < ApplicationController
	before_action :set_cart, only: [:show, :edit, :update, :destroy]
	rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart 


	def destroy
		@cart.destroy if @cart.id == session[:cart_id]
		session[:cart_id] = nil
		respond_to do |format|
			format.html { redirect_to store_url,
				notice: 'Your Cart is currently empty'}
			format.json {head :no_content}
		end
	end

	private

	def set_cart
		@cart = Cart.find(params[:id])
	end

	def invalid_cart
		logger.error "Someone tried to access an invalid cart #{params[:id]}"
		redirect_to store_url, notice: 'Cart not found'
	end
end
