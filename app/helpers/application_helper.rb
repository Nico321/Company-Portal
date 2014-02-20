module ApplicationHelper

	def show_notes(object, addbutton, objectID)
		nrOfNotes = object.notes.count
		if object.class != Bugreport
			if object.offer
				nrOfNotes += object.offer.notes.count
				if object.offer.assignment
					nrOfNotes += object.offer.assignment.notes.count
					if object.offer.assignment.order
						nrOfNotes += object.offer.assignment.order.notes.count
						if object.offer.assignment.order.installation
							nrOfNotes += object.offer.assignment.order.installation.notes.count
							if object.offer.assignment.order.installation.invoice
								nrOfNotes += object.offer.assignment.order.installation.invoice.notes.count
							end
						end
					end
				end
			end
		end
		html = "
				<div class='accordion' id='accordionNote'>
				    <div class='accordion-group'>
				      <div class='accordion-heading'>
				        <a class='accordion-toggle' data-toggle='collapse' data-parent='#accordion2' href='#collapseNoteOne'>
				        Notes(#{nrOfNotes})
				        </a>
				      </div>
				      <div id='collapseNoteOne' class='accordion-body collapse'>
				        <div class='accordion-inner'>"

						html += show_note_helper(object)
					
						if object.class == Request
							if object.offer
								html += show_note_helper(object.offer)

								if object.offer.assignment
									html += show_note_helper(object.offer.assignment)

									if object.offer.assignment.order
										html += show_note_helper(object.offer.assignment.order)

										if object.offer.assignment.order.installation
											html += show_note_helper(object.offer.assignment.order.installation)

											if object.offer.assignment.order.installation.invoice
												html += show_note_helper(object.offer.assignment.order.installation.invoice)
											end
										end
									end
								end
							end
						end

						if addbutton
							html +=	"<div style='float: right;'><a href='#{new_note_path}?#{addbutton}_id=#{objectID}' class='btn btn-primary'>Add a note</a></div>"
						end
		
		html +="		</div>
				      </div>
				    </div>
				</div>
						"
				

		return html
	end

	def show_note_helper(object)
		notes = ""

		object.notes.each do |n|				          
		notes += "
		<div class='accordion-group #{object.class}Note' data-parent='#collapseOne'>
            <div class='accordion-heading'>
              <a class='accordion-toggle' data-toggle='collapse' href='#collapse#{n.id}'>
              #{n.subject}<div style='float: right;'>#{n.user.email}(#{l n.created_at, format: :short})</div>
              </a>
            </div>
            <div id='collapse#{n.id}' class='accordion-body collapse'>
              <div class='accordion-inner'>
              #{n.body}
              </div>
            </div>
          </div>"		
		end
		return notes
	end


	def show_positions(object)

				html = "
				<div class='accordion' id='accordionPos'>
				    <div class='accordion-group'>
				      <div class='accordion-heading'>
				        <a class='accordion-toggle' data-toggle='collapse' data-parent='#accordion2' href='#collapsePosOne'>
				        Positions(#{object.positions.count})
				        </a>
				      </div>
				      <div id='collapsePosOne' class='accordion-body collapse'>
				        <div class='accordion-inner'><table class='table table-hover'><tr>
				        <th>Quantity</th>
				        <th>Name</th>
				        <th>Price</th>
				        <th>Total</th>"
				        if object.class == Order
				        	html += "<th>Estimated deliverydate</th><th></th>"
				        end
				        html += "</tr>"
							object.positions.each do |p|
								arrived = ""
								if p.arrived and object.class == Order
									arrived = "arrived"
								end	
								html += "
								<tr class='#{arrived}'>
									<td>
										#{p.quantity}
									</td>
									<td>
										#{p.article.name}
									</td>
									<td>
										#{p.article.price}
									</td>
									<td>
										#{p.article.price * p.quantity}
									</td>"
									if object.class == Order
										html += "<td>"
										
										if p.arrived
											html += "#{p.deliverydate}</td><td>#{p.arrived}"
										else
											html += "
											<form action='#{updateDeliverydate_position_path(p)}' method='post'>
											<input name='authenticity_token' value='#{form_authenticity_token}' type='hidden'>
											<input name='deliverydate' type='text' data-behaviour='datepicker' value ='#{p.deliverydate}'>
											<input type='submit' value='Update Deliverydate' class='btn btn-info'>
											</form>"
											html += "</td>
											<td>"
											html +="<a href='#{arrive_position_path(p)}' class='btn btn-success'>Arrived</a>"
										end
										html += "</td></tr>"	
									end					
							end
							html += "</table>"
			if object.class == Offer		          
				if current_user == object.agent and object.publication == nil
					html +=	"	<div style='float: right;'>#{link_to 'Add a position', new_position_path(:offer_id => object.id), :class => 'btn btn-primary'}</div>"
				end
			end		
			html += "</div>
				      </div>
				    </div>
				</div>
						"
		return html

	end

	def calcTotalPrice(object)
		
		totalAmount = 0
		object.positions.each do |p|
		 	totalAmount += p.article.price * p.quantity
		 end
		 if object.installationprice
		 	totalAmount += object.installationprice
		 end

		 return totalAmount
	end

	def sortable(column, title = nil)
		title ||= column.titleize
		css_class = column == params[:sort] ? "current #{params[:direction]}" : nil
		direction = column == params[:sort] && params[:direction] == "asc" ? "desc" : "asc"
		link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
	end

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



