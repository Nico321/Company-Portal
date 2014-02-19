module ArchiveHelper

	def showTable(object, searchparam, directionparam, sortparam)

	    if object.class == Request
	    	path = request_path
	    elsif object.class == Offer
	    	path = offer_path
	    elsif object.class == Assignment
	    	path = assignment_path
	    elsif object.class == Order
	    	path = order_path
	    elsif object.class == Installation
	    	path = installation_path
	    elsif object.class == Invoice
	    	path = invoice_path
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
