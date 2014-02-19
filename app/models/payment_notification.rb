class PaymentNotification < ActiveRecord::Base	
	belongs_to :invoice
	serialize :params

	after_create :mark_invoice_as_purchased

	def mark_invoice_as_purchased
	  if status == "Completed"
	    invoice.update_attribute(:payed, Time.now)
	  end
	end
end
