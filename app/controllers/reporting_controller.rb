class ReportingController < ApplicationController
	def index
		#common Reporting information & creation from given data
		@bugreport = Bugreport.all
		summe = 0
		@bugreport.each do	|bugreport|
			if bugreport.closed != nil
			summe = bugreport.closed - bugreport.created_at
			end
		end
		if Bugreport.all.count(:closed) != 0
			@allAverageTimeBug = (summe/ Bugreport.all.count(:closed)/60).round
		end
		@openBugreports = Bugreport.all.count(:agent == nil)
		@requestQuantity = Request.all.count
		@offerQuantity = Offer.all.count
		@userAll = User.all.count
		@userOnline = User.online.count
	end

#------------------------------------------------------------------------------
#General funktions
#------------------------------------------------------------------------------
	def createBarChart(size, title, barColor1, barColor2, legend1, legend2, data_array, max, axis_labels)
		#creates a Bar Chart with given parameters from bugreport method
		if data_array != nil
			chart = Gchart.bar(
	            :size => size,
	            :bar_colors => [barColor1, barColor2],
	            :title => title,
	            :bg => 'EFEFEF',
	            :legend => [legend1, legend2],
	            :data => data_array,
	            :stacked => false,
	            :max_value => max,
	            :min_value => 0,
	            :filename => 'images/bar_chart.png',
	            :legend_position => 'bottom',
         	   	:axis_with_labels => [['x'], ['y']], 	
	            :axis_labels => axis_labels,
	        )
	        return chart
		end
	end
#------------------------------------------------------------------------------
#Bugreport Methods
#------------------------------------------------------------------------------
	def bugreport
		#Bugreport intervall choose
		#Method for bugreport view
		@mydata = params[:value]
		case @mydata
			when "0"
				@chart =	createBarChart("400x400", "Created/Closed", "FF0000", "008000", "Created", "Closed", bugreportsShow(0,0,0),Bugreport.all.count, ["All"])			
			when "1"
				@chart =	createBarChart("650x400","Created/Closed", "FF0000", "008000", "Created", "Closed", bugreportsShow(Time.now.year,0,0), Bugreport.all.count, [["Jan", "Feb", "Mar", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]])
			when "2"
				@chart = 	createBarChart("750x400","Created/Closed", "FF0000", "008000", "Created", "Closed", bugreportsShow(Time.now.year,Time.now.month,Time.now.day), Bugreport.all.count, [["-12","-11","-10", "-9","-8","-7", "-6", "-5", "-4", "-3", "-2", "-1"]])
		end
		@agents = EmployeeQuantity()
	end

	def bugreportsShow(iyear, imonth, iday)
		#This method creates an data_array to show the bugreports
		month = Array.new(2){Array.new(12)}	#2dem Array to save created and closed Bugreports
		hours = Array.new(2){Array.new(12)}
		i = 0
		until i == 12 do
			i += 1
			if i<10
				month[0][i-1] = Bugreport.where("created_at like '?-0?%'",iyear, i).count
				month[1][i-1] = Bugreport.where("closed 	like '%?-0?%'",iyear, i).count
			 else
				month[0][i-1] = Bugreport.where("created_at like '%?-?%'",iyear, i).count
				month[1][i-1] = Bugreport.where("closed 	like '%?-?%'",iyear, i).count
			end
		end
		#-----------Daybreaks-------
		time = Time.now.hour-12
			if time < 1
				time = time*-1
			end
		counter = 0
		until time == Time.now.hour do
			counter+= 1
			time+= 1
			if time == 0		#if time was negative we have to change the date at 00
					time = 1
					iday += 1
			end
			if imonth < 10 && iday <10 && time < 10
				hours[0][counter] = Bugreport.where("created_at like '?-0?-0? 0?%'", iyear, imonth, iday, time).count
				hours[1][counter] = Bugreport.where("closed 	like '?-0?-0? 0?%'", iyear,imonth, iday, time).count
			elsif imonth < 10 && iday <10 && time >= 10
			 	hours[0][counter] = Bugreport.where("created_at like '?-0?-? ?%'", iyear, imonth, iday, time).count
			 	hours[1][counter] = Bugreport.where("closed 	like '?-0?-0? ?%'", iyear, imonth, iday, time).count
			 elsif imonth < 10 && iday >= 10 && time >= 10
				hours[0][counter] = Bugreport.where("created_at like '?-0?-? ?%'", iyear, imonth, iday, time).count
				hours[1][counter] = Bugreport.where("closed 	like '?-0?-? ?%'",iyear, imonth, iday, time).count
			 elsif	imonth >= 10 && iday >= 10 && time >= 10
				hours[0][counter] = Bugreport.where("created_at like '?-?-? ?%'", iyear, imonth, iday, time).count
				hours[1][counter] = Bugreport.where("closed 	like '?-?-? ?%'", iyear, imonth, iday, time).count 	
			end	
		end
	
		if(iyear == 0 && imonth == 0 && iday == 0)
			return [[Bugreport.all.count], [Bugreport.where("closed").count]]

		 elsif (iyear != 0 && imonth == 0 && iday == 0)
			return month
		 elsif (iyear != 0 && imonth != 0 && iday != 0)
			return hours
		end
	end

	def EmployeeQuantity
		agent = Array.new(User.count)
		Bugreport.all.each do |bug|
			if bug.agent_id != nil
				agent[bug.agent_id] = bug.agent_id
			end
		end
		return agent
	end
#------------------------------------------------------------------------------
#Businessprocess Methods
#------------------------------------------------------------------------------
	def businessprocess
		@info = params[:info]
		case @info
		 when "0"
			@test =3
		 when "1"
			@test =3
		 when "2"
			@test =3
		end

		@infos = getBusinessprocessData
		
	end

	def getBusinessprocessData
		main			= Array.new(6)  #Array for all processsteps
		requests 		= Array.new(3) #all, open, unassumed
		offers			= Array.new(3) #all, open, unassumed
		assignments		= Array.new(3) #all, open, unassumed
		orders			= Array.new(5)
		installations	= Array.new(4) #all, open, unassumed, installed
		invoices		= Array.new(5) #all payed -> nil nicht bezahlt (date feld)

		requests[0] 	= Request.count
		requests[1] 	= Request.where("offer_id is null").count
		requests[2] 	= Request.where("agent_id is null").count

		offers[0] 		= Offer.count
		offers[1] 		= Offer.where("assignment_id is null").count
		offers[2] 		= Offer.where("agent_id is null").count

		assignments[0] 	= Assignment.count
		assignments[1]	= Assignment.where("order_id is null").count
		assignments[2] 	= Assignment.where("agent_id is null").count

			orders[0] = 0
			if !Order.all.blank?
			   for order in Order.all
			   	if !order.blank?
					orders[0] += order.installationprice
				end
			   end 
			 end

		installations[0] 	= Installation.count
		installations[1]	= Installation.where("invoice_id is null").count
		installations[2] 	= Installation.where("agent_id is null").count
		installations[3]	= Installation.where("installationdate < #{Time.now.year}-#{Time.now.month}-#{Time.now.day}").count		

		main[0] = requests
		main[1] = offers
		main[2] = assignments
		main[3] = orders
		main[4] = installations
		main[5] = invoices

		return main
	end
end