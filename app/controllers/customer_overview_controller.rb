class CustomerOverviewController < ApplicationController
  def index
  	@requests = Request.where("customer_id = '#{current_user.id}'")
  	@offers = Offer.where("customer_id = '#{current_user.id}'")
  	@assignments = Assignment.where("customer_id = '#{current_user.id}'")
  	@orders = Order.where("customer_id = '#{current_user.id}'")
  	@installations = Installation.where("customer_id = '#{current_user.id}'")
  	@invoices = Invoice.where("customer_id = '#{current_user.id}'")
  end
end
