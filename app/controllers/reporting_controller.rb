class ReportingController < ApplicationController

# proplem with NameError in ReportingController#index when load_and_authorize_resource is implemented
# also when implemented in link restrictions
load_and_authorize_resource


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
			@allAverageTimeBug = ((summe/ Bugreport.all.count(:closed))/60).round(2)
		end
		@openBugreports = Bugreport.all.count(:agent == nil)
		@userAll = User.all.count
		@userOnline = User.online.count
		if Installation.where("installationdate > '#{Time.now.year}-#{Time.now.ago(1.month).strftime("%m")}-01'").count.to_d == 0
			@installations = "cant be solved"
		 else
			@installations = (Installation.where("installationdate > '#{Time.now.year}-#{Time.now.strftime("%m")}'").count.to_d / Installation.where("installationdate = '#{Time.now.year}-#{Time.now.ago(1.month).strftime("%m")}'").count.to_d)-1
		end
		@userOnline = User.online.count
		if Request.where("created_at = '#{Time.now.year}-#{Time.now.ago(1.month).strftime("%m")}'").count.to_d == 0
			@requests = "cant be solved"
		 else
			@requests = (Request.where("created_at > '#{Time.now.year}-#{Time.now.strftime("%m")}'").count.to_d / Request.where("created_at = '#{Time.now.year}-#{Time.now.ago(1.month).strftime("%m")}'").count.to_d)-1
		end
	end

#------------------------------------------------------------------------------
#General funktions
#------------------------------------------------------------------------------
	def createBarChart(size, title, barColor, legend, data_array, max, axis_labels)
		#creates a Bar Chart with given parameters from bugreport method
		if data_array != nil
			chart = Gchart.bar(
	            :size => size,
	            :bar_colors => barColor,
	            :title => title,
	            :bg => 'FFFFFF',
	            :legend => legend,
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

	def createMeterChart(title, data, lable)
		if !data.blank?
			chart = Gchart.meter(
				:title => title,
				:data 	=> [data],
				:lable 	=> "#{lable}",
			)
		end
		return chart
	end

	def createPieChart(size, title, data, lable)
		if !data.blank?
			chart = Gchart.pie_3d(
				:title => title, 
				:size => size,
	            :data => data,
	            :labels => lable
        	)
		end
        return chart
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
				@chart =	createBarChart("400x400", "Created/Closed", ["FF0000", "008000"], ["Created", "Closed"], bugreportsShow(0,0,0),Bugreport.all.count, ["All"])			
			when "1"
				@chart =	createBarChart("650x400", "Created/Closed", ["FF0000", "008000"], ["Created", "Closed"], bugreportsShow(Time.now.year,0,0), Bugreport.all.count, [["Jan", "Feb", "Mar", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]])
			when "2"
				@chart = 	createBarChart("750x400", "Created/Closed", ["FF0000", "008000"], ["Created", "Closed"], bugreportsShow(Time.now.year,Time.now.month,Time.now.day), Bugreport.all.count, [["-12","-11","-10", "-9","-8","-7", "-6", "-5", "-4", "-3", "-2", "-1"]])
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
				month[0][i-1] = Bugreport.where("created_at >= '#{iyear}-0#{i}-01' AND created_at <= '#{iyear}-0#{i+1}-01'",iyear, i).count
				month[1][i-1] = Bugreport.where("closed >= '#{iyear}-0#{i}-01' AND closed <= '#{iyear}-0#{i+1}-01'",iyear, i).count
			 else
				month[0][i-1] = Bugreport.where("created_at >= '#{iyear}-#{i}-01' AND created_at <= '#{iyear}-#{i+1}-01'",iyear, i).count
				month[1][i-1] = Bugreport.where("closed >= '#{iyear}-#{i}-01' AND closed <= '#{iyear}-#{i+1}-01'",iyear, i).count
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
				hours[0][counter] = Bugreport.where("created_at >= '#{iyear}-0#{imonth}-0#{iday} 0#{time}' AND created_at <= '#{iyear}-0#{imonth}-0#{iday} 0#{time+1}'", iyear,imonth, iday, time).count
				hours[1][counter] = Bugreport.where("closed >= '#{iyear}-0#{imonth}-0#{iday} 0#{time}' AND closed <= '#{iyear}-0#{imonth}-0#{iday} 0#{time+1}'", iyear,imonth, iday, time).count
			elsif imonth < 10 && iday <10 && time >= 10
				hours[0][counter] = Bugreport.where("created_at >= '#{iyear}-0#{imonth}-0#{iday} #{time}' AND created_at <= '#{iyear}-0#{imonth}-0#{iday} #{time+1}'", iyear,imonth, iday, time).count
				hours[1][counter] = Bugreport.where("closed >= '#{iyear}-0#{imonth}-0#{iday} #{time}' AND closed <= '#{iyear}-0#{imonth}-0#{iday} #{time+1}'", iyear,imonth, iday, time).count
			 elsif imonth < 10 && iday >= 10 && time >= 10
				hours[0][counter] = Bugreport.where("created_at >= '#{iyear}-0#{imonth}-#{iday} #{time}' AND created_at <= '#{iyear}-0#{imonth}-#{iday} #{time+1}'", iyear,imonth, iday, time).count
				hours[1][counter] = Bugreport.where("closed >= '#{iyear}-0#{imonth}-#{iday} #{time}' AND closed <= '#{iyear}-0#{imonth}-#{iday} #{time+1}'", iyear,imonth, iday, time).count
			 elsif	imonth >= 10 && iday >= 10 && time >= 10
				hours[0][counter] = Bugreport.where("created_at >= '#{iyear}-#{imonth}-#{iday} #{time}' AND created_at <= '#{iyear}-#{imonth+1}-#{iday+1} #{time+1}'", iyear,imonth, iday, time).count
				hours[1][counter] = Bugreport.where("closed >= '#{iyear}-#{imonth}-#{iday} #{time}' AND closed <= '#{iyear}-#{imonth}-#{iday} #{time+1}'", iyear,imonth, iday, time).count
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
		array = getBusinessprocessData("0")
		@info = params[:info]
		case @info
		 when "0"
		 	array = getBusinessprocessData("0")
		 when "1"
			legend = Array.new(2)
		 	legend[0] = "Last Year"
		 	legend[1] = "Actual Year"
			array = getBusinessprocessData("year")
			arrayPast = getBusinessprocessData("lastYear")

		 when "2"
		 	legend = Array.new(2)
		 	legend[0] = "yesterday"
		 	legend[1] = "today"
			array = getBusinessprocessData("day")
			arrayPast = getBusinessprocessData("lastDay")
		end

			if arrayPast != nil	
				i = 0
				big = 0
				until i == 5
					if array != nil && arrayPast != nil
					 if array[i][0] != nil && arrayPast[i][0] != nil
						if array[i][0] < arrayPast[i][0]
							if arrayPast[i][0] > big
								big = arrayPast[i][0]
							end
						 else
						 	if array[i][0] > big
								big = array[i][0]
							end
						end
					 end
					end
				i +=1
				end
				@chart1 = createBarChart("400x400", "Comparison", ["FF0000", "00FF00", "AEDCDE", "0000FF", "330000","7446E9"], ["Requests", "Offers", "Assignments", "Orders", "Installations", "Invoices"], [[arrayPast[0][0],array[0][0]], [arrayPast[1][0], array[1][0]], [arrayPast[2][0], array[2][0]], [arrayPast[3][0], array[3][0]], [arrayPast[4][0], array[4][0]], [arrayPast[5][0], array[5][0]]], big, [legend])			
			end
			@chart2 = createMeterChart("Positions in time", array[6], 0)
		
			if (array[2][1].to_f / array[2][1]*100.to_f).class.to_s == "float"
				@OtA = (array[2][1].to_f / array[2][1]*100.to_f)
			 else
				@OtA = 0
			end

			@Opayed =  (array[5][2].to_f / array[3][0])*100.to_f
			@customer = array[7]
			@Ovolume = array[3][1]
			@Avolume = array[5][3]
	end

	def getBusinessprocessData(time)
		if time == "year"
			t = Time.now.year
			y = Time.now.year
			m = 0
			d = 0
			ymd = "created_at >= '#{Time.local(y,1,1)}'"
			pay = "payed like '#{y}'"
		 elsif time == "day"
		 	t = Time.local(Time.now.year, Time.now.month, Time.now.day)
		 	iyear = Time.now.year
			imonth = Time.now.month
			iday = Time.now.day
			if iday < 10 && imonth < 10
				ymd = "created_at >= '#{iyear}-0#{imonth}-0#{iday}' AND created_at <= '#{iyear}-0#{imonth}-0#{iday+1}'"
				pay = "payed >= '#{iyear}-0#{imonth}-0#{iday}' AND payed <= '#{iyear}-0#{imonth}-0#{iday+1}'"
			 elsif iday < 10
			 	ymd = "created_at >= '#{iyear}-#{imonth}-0#{iday}' AND created_at <= '#{iyear}-#{imonth}-0#{iday+1}'"
				pay = "payed >= '#{iyear}-#{imonth}-0#{iday}' AND payed <= '#{iyear}-#{imonth}-0#{iday+1}'"
			 elsif imonth < 10
				ymd = "created_at >= '#{iyear}-0#{imonth}-#{iday}' AND created_at <= '#{iyear}-0#{imonth}-#{iday+1}'"
				pay = "payed >= '#{iyear}-0#{imonth}-#{iday}' AND payed <= '#{iyear}-0#{imonth}-#{iday+1}'"
			 else	
				ymd = "created_at >= '#{iyear}-0#{imonth}-0#{iday}' AND created_at <= '#{iyear}-0#{imonth}-0#{iday+1}'"
				pay = "payed >= '#{iyear}-0#{imonth}-0#{iday}' AND payed <= '#{iyear}-0#{imonth}-0#{iday+1}'"
			end
		 elsif time == 0		 	
		 	t = 0
		 	y = 0
			m = 0
			d = 0
			ymd = ymd = "created_at >= '#{Time.local(y,m,d)}'"
			pay = "payed is not null"
		 elsif time == "lastYear"
		 	t = (Time.now.year)-1
			iyear = (Time.now.year)-1
			imonth = 0
			iday = 0
			ymd = "created_at >= '#{iyear}-0#{imonth}-0#{iday}' AND created_at <= '#{iyear+1}-0#{imonth}-0#{iday}'"
			pay = "payed >= '#{iyear}-0#{imonth}-0#{iday}' AND payed <= '#{iyear+1}-0#{imonth}-0#{iday}'"
		 elsif time == "lastDay"
		 	t = Time.local(Time.now.year, Time.now.month, Time.now.day)
		 	iyear = Time.now.year
			imonth = Time.now.month
			iday = (Time.now.day)-1
			if iday < 10 && imonth < 10
				ymd = "created_at >= '#{iyear}-0#{imonth}-0#{iday}' AND created_at <= '#{iyear}-0#{imonth}-0#{iday+1}'"
				pay = "payed >= '#{iyear}-#{imonth}-0#{iday}' AND payed <= '#{iyear}-#{imonth}-0#{iday+1}'"
			 elsif iday < 10
				ymd = "created_at >= '#{iyear}-0#{imonth}-0#{iday}' AND created_at <= '#{iyear}-#{imonth}-0#{iday+1}'"
				pay = "payed >= '#{iyear}-#{imonth}-0#{iday}' AND payed <= '#{iyear}-#{imonth}-#{iday+1}'"
			 elsif imonth < 10
				ymd = "created_at >= '#{iyear}-0#{imonth}-0#{iday}' AND created_at <= '#{iyear}-0#{imonth}-#{iday+1}'"
				pay = "payed >= '#{iyear}-0#{imonth}-0#{iday}' AND payed <= '#{iyear}-#{imonth}-#{iday+1}'"
			 else	
				ymd = "created_at >= '#{iyear}-#{imonth}-#{iday}' AND created_at <= '#{iyear}-#{imonth}-#{iday+1}'"
				pay = "payed >= '#{iyear}-#{imonth}-#{iday}' AND payed <= '#{iyear}-#{imonth}-#{iday+1}'"
			end
		end	

		main			= Array.new(8)  #Array for all processsteps
		requests 		= Array.new(3) #all, open, unassumed
		offers			= Array.new(3) #all, open, unassumed
		assignments		= Array.new(3) #all, open, unassumed
		orders			= Array.new(5) #installationprice, all
		installations	= Array.new(4) #all, open, unassumed, installed
		invoices		= Array.new(4) #all payed -> nil nicht bezahlt (date feld)
		positions		= 0

		requests[0] 	= Request.where(ymd).count
		requests[1] 	= Request.where("offer_id is null AND created_at >= '#{t}'").count
		requests[2] 	= Request.where("agent_id is null AND created_at >= '#{t}'").count

		offers[0] 		= Offer.where(ymd).count
		offers[1] 		= Offer.where("assignment_id is null AND created_at >= '#{t}'").count
		offers[2] 		= Offer.where("agent_id is null AND created_at >= '#{t}'").count

		assignments[0] 	= Assignment.where(ymd).count
		assignments[1]	= Assignment.where("order_id is not null AND created_at >= '#{t}'").count
		assignments[2] 	= Assignment.where("agent_id is null AND created_at >= '#{t}'").count

			orders[1] = 0
			if !Order.all.blank?
				div = 0
			   for order in Order.all.where(ymd)
			   	if !order.blank?
					orders[1] += order.installationprice
					div += 1
				end
			   end
				if div == 0
					orders[1] = 0
				 else
				 	orders[1] = orders[1] / div
				end
			end
			orders[0] = Order.count

		installations[0] 	= Installation.where(ymd).count
		installations[1]	= Installation.where("invoice_id is null AND created_at >= '#{t}'").count
		installations[2] 	= Installation.where("agent_id is null AND created_at >= '#{t}'").count
		installations[3]	= Installation.where("installationdate < #{Time.now.year}-#{Time.now.month}-#{Time.now.day} AND created_at >= '#{t}'").count

		invoices[0]	= Invoice.where(ymd).count
		invoices[1] = Invoice.where("payed is null AND created_at >= '#{t}'").count
		invoices[2] = Invoice.where("payed is not null AND created_at >= '#{t}'").count
		invoices[3] = 0

		Invoice.all.where(ymd).each do |invoice|
			sumPos=0
			invoice.positions.each do |pos|
				sumPos += pos.article.price
			end
			sumPos += invoice.installationprice
			invoices[3] += sumPos
		end

		if !Position.all.blank?
			   for position in Position.all
			   	if !position.blank?
			   		if !position.arrived.blank?
						positions += (position.deliverydate - position.arrived.to_date).to_i
					end
				end
			   end 
		end

	def findCustomer(customer, invoice)
		pos=0
		until pos == customer.length
			if customer[pos][0] == invoice.customer_id
				return pos
			end
			pos +=1
		end
	end

		if !Invoice.all.blank?
			if !(User.with_role :customer) != 0
				customer = Array.new((User.with_role :customer).count){Array.new(2)}
				 Invoice.all.where(pay).each do |invoice|
				 	if findCustomer(customer, invoice) == nil
				 			i = 0
				 		customer.each do |cu|
				 			if cu[1] != nil
				 				i += 1
				 			 else
				 				i += 0
				 			end
				 		end
				 		customer[i][0] = invoice.customer_id
				 		if !invoice.installationprice.blank?
					 		customer[i][1] = invoice.installationprice
					 			invoice.positions.each do |pos|
									customer[i][1] += pos.article.price
								end
						end
					 else
					 	if invoice.installationprice != nil && (findCustomer(customer, invoice)) != nil
					 		customer[(findCustomer(customer, invoice))][1] += invoice.installationprice
					 			invoice.positions.each do |pos|
									customer[findCustomer(customer, invoice)][1] += pos.article.price
								end
						end
				 	end
				end
				customer.each do |cu|
					if cu[1].blank?
						cu[1] = 0
					end
				end
				#customer.sort_by(&:last)
				customer.sort_by{|x,y|y}
			end
		end

		# to return only one array
		main[0] = requests
		main[1] = offers
		main[2] = assignments
		main[3] = orders
		main[4] = installations
		main[5] = invoices
		main[6] = positions
		main[7] = customer
		return main
	end

#------------------------------------------------------------------------------
#User Methods
#------------------------------------------------------------------------------
	def user
		@user = getUserInfos
		@chart = createPieChart("400x200", "user spreading", [getUserInfos[0][0].count,getUserInfos[1][0].count,getUserInfos[2][0].count,getUserInfos[3][0].count,getUserInfos[4][0].count], [getUserInfos[0][1], getUserInfos[1][1],getUserInfos[2][1], getUserInfos[3][1], getUserInfos[4][1]])
	
		@mydata = params[:value]
		case @mydata
			when "0"
				@list = getUserInfos[0]
			when "1"		
			when "2"
			when "3"
			when "4"		
		end
	end

	def getUserInfos
		user = Array.new(5){Array.new(2)}
		user[0][0] = (User.with_role :superadmin)
		user[1][0] = (User.with_role :sales)
		user[2][0] = (User.with_role :customer)
		user[3][0] = (User.with_role :accountend)
		user[4][0] = (User.with_role :technican)

		user[0][1] = "superadmin"
		user[1][1] = "sales"
		user[2][1] = "customer"
		user[3][1] = "accountend"
		user[4][1] = "technican"
	 return user
	end

#------------------------------------------------------------------------------
#User Shop
#------------------------------------------------------------------------------

	def shop
		all = getItems
		@top = all[0..9]
		@worst = all[getItems.length-10..getItems.length]
	end

	def findItem(items ,position)
		pos= 0
		until pos == items.length
			if items[pos][0] == position.article_id
				return 3
			end
			pos +=1
		end
	return nil
	end

	def getItems
		if !Article.count.blank? && !Invoice.count.blank?
			items = Array.new(Article.all.count){Array.new(2)}
			if !Invoice.all.blank?
				Invoice.all.each do |invoice|
					if !invoice.positions.blank?
						invoice.positions.each do |position|
							if findItem(items, position) == nil
								i = -1
								items.each do |item|
									if items != nil
										i +=1
									 else
									 	i +=0
									end
									items[i][0] = position.article_id
									items[i][1] = position.quantity
							 	end
							 else
							 	itmes[findItem(items, position)][1] += position.quantity
							end
						end
					end
				end
			end
			items.sort_by(&:last)
		end
		return items
	end
end