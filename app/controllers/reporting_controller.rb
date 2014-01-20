class ReportingController < ApplicationController
	def index
		#common Reporting information & creation from given data
		@bugreport = Bugreport.all
		#@allAverageTimeBug = ((Bugreport.all.sum(:created_at) - Bugreport.all.sum(:closed))/60).round
		summe = 0
		@bugreport.each do	|bugreport|
			summe = bugreport.closed - bugreport.created_at
		end
		@allAverageTimeBug = (summe/ Bugreport.all.count(:closed)/60).round

		@openBugreports = Bugreport.all.count(:agent == nil)

		@requestQuantity = Request.all.count
		@offerQuantity = Offer.all.count

		@userAll = User.all.count
		@userOnline = User.online.count
	end

	def bugreport
		#Bugreport specefic information & creation

		@mydata = params[:value]

		case @mydata
		when "1"
			@chart = Gchart.bar(:data => [00, 00, 30, 00])
		when "2"
			@chart = Gchart.bar(:data => [10, 00, 30, 00])
		when "3"
			@chart = Gchart.bar(:data => [00, 20, 30, 00])
		when "4"
			@chart = Gchart.bar(:data => [00, 00, 30, 40])
		end
	end
end
