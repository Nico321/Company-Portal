class CustomerOverviewController < ApplicationController
  def index
  	@requests = Request.where("customer_id = '#{current_user.id}' and offer_id IS NULL")
  	@offers = Offer.where("customer_id = '#{current_user.id}' AND assignment_id IS NULL")
  	@assignments = Assignment.where("customer_id = '#{current_user.id}' and order_id IS NULL")
  	@orders = Order.where("customer_id = '#{current_user.id}' is installation_id IS NULL")
  	@installations = Installation.where("customer_id = '#{current_user.id}' and invoice_id IS NULL")
  	@invoices = Invoice.where("customer_id = '#{current_user.id}'")
  end
end
