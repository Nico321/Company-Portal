module ArchiveHelper

	def showTable(object, searchparam, directionparam, sortparam)
		if object
		    if object.first.class == Request
		    	path = requests_path
		    elsif object.first.class == Offer
		    	path = offers_path
		    elsif object.first.class == Assignment
		    	path = assignments_path
		    elsif object.first.class == Order
		    	path = orders_path
		    elsif object.first.class == Installation
		    	path = installations_path
		    elsif object.first.class == Invoice
		    	path = invoices_path
		    end
		end

	html = "
		<form action='#{path}' method ='get' id ='#{object.class}_search'>
		  <p>
		  	<input type='text' name='search' value='#{searchparam}' placeholder='Search for a subject'></input>
		  	<input type='submit' value='Search' class='btn btn-default'></input>
		  </p>

		<table class='table table-hover'>
		  <thead>
		    <tr>
		      <th>#{sortable 'customer_id', 'Customer'}</th>
		      <th>#{sortable 'subject', 'Subject'}</th>
		      <th>#{sortable 'agent_id', 'Agent'}</th>
		      <th></th>
		      <th></th>
		    </tr>
		  </thead>

		  <tbody>"
		  if object != nil
		    object.each do |object|
		      html += "
		      <tr>
		        <td>#{object.customer.email}</td>
		        <td>#{object.subject}</td>"
		        if object.agent
		          html += "<td>#{object.agent.email}</td>"
		        else
		        	html += "<td></td>"
		        end


		        html += "<td><a href='#{path}/#{object.id}' class='btn btn-info'>Show</a> </td>
		      </tr>"
		    end
		end
		html += "</tbody>
		</table>		  
		<div id='#{object.class}hidden'>
		  	<input type='hidden' name='direction' value='#{directionparam}'></input>
		  	<input type='hidden' name='sort' value='#{sortparam}'></input>
			
			#{will_paginate object}
		  </div>
		</form>"
	end

end
