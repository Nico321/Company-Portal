class ArchiveController < ApplicationController

	def index

		if params[:sort] == nil
			params[:sort] = 'customer_id'
		end
		if params[:direction] == nil
			params[:direction] = "asc"
		end

	  	@requests = Request.where("offer_id IS NOT NULL").search(params[:search]).order(params[:sort] + " " + params[:direction]).paginate(:per_page => 5, :page => params[:page])
	  	@offers = Offer.where("assignment_id IS NOT NULL").search(params[:search]).order(params[:sort] + " " + params[:direction]).paginate(:per_page => 5, :page => params[:page])
	  	@assignments = Assignment.where("order_id IS NOT NULL").search(params[:search]).order(params[:sort] + " " + params[:direction]).paginate(:per_page => 5, :page => params[:page])
	  	@orders = Order.where("installation_id IS NOT NULL").search(params[:search]).order(params[:sort] + " " + params[:direction]).paginate(:per_page => 5, :page => params[:page])
	  	@installations = Installation.where("invoice_id IS NOT NULL").search(params[:search]).order(params[:sort] + " " + params[:direction]).paginate(:per_page => 5, :page => params[:page])
	  	@invoices = Invoice.where("payed IS NOT NULL").search(params[:search]).order(params[:sort] + " " + params[:direction]).paginate(:per_page => 5, :page => params[:page])
	end
end