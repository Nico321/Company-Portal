class ReportingController < ApplicationController
	def index
		@bugreport = Bugreport.all	
	end

end
