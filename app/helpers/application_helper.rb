# encoding: UTF-8
module ApplicationHelper

	def show_notes(object, addbutton, objectID)
		nrOfNotes = countNotes(object)
		
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

	def countNotes(object)
		if object.class == Request
			nrOfNotes = count_RequestNotes(object)
		elsif object.class == Offer
			nrOfNotes = count_RequestNotes(object.request)
		elsif object.class == Assignment
			nrOfNotes = count_RequestNotes(object.offer.request)
		elsif object.class == Order
			nrOfNotes = count_RequestNotes(object.assignment.offer.request)
		elsif object.class == Installation
			nrOfNotes = count_RequestNotes(object.order.assignment.offer.request)
		elsif object.class == Invoice
			nrOfNotes = count_RequestNotes(object.installation.order.assignment.offer.request)
				
		end

		return nrOfNotes
	end

	def count_RequestNotes(object)
		nrOfNotes = object.notes.count
		if object.offer
			if object.offer.assignment
				if object.offer.assignment.order
					if object.offer.assignment.order.installation
						if object.offer.assignment.order.installation.invoice
							nrOfNotes += object.offer.notes.count + object.offer.assignment.notes.count + object.offer.assignment.order.notes.count	+ object.offer.assignment.order.installation.notes.count + object.offer.assignment.order.installation.invoice.notes.count
						else
							nrOfNotes += object.offer.notes.count + object.offer.assignment.notes.count + object.offer.assignment.order.notes.count	+ object.offer.assignment.order.installation.notes.count
						end
					else
						nrOfNotes += object.offer.notes.count + object.offer.assignment.notes.count + object.offer.assignment.order.notes.count	
					end
				else
					nrOfNotes += object.offer.notes.count + object.offer.assignment.notes.count
				end
			else
				nrOfNotes += object.offer.notes.count
			end
		end
		return nrOfNotes
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
										#{p.article.price} €
									</td>
									<td>
										#{p.article.price * p.quantity} €
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

	def showTable(object, searchparam, directionparam, sortparam, editlink = false, assumable = false, publication = false)
		if object
			showpath=getObjectPath(object.first)
		end
	html = "
		<form action='#{showpath}' method ='get' id ='#{object.class}_search'>
		  <p>
		  	<input type='text' name='search' value='#{searchparam}' placeholder='Search for a subject'></input>
		  	<input type='submit' value='Search' class='btn btn-default'></input>
		  </p>

		<table class='table table-hover'>
		  <thead>
		    <tr>
		      <th>#{sortable 'customer_id', 'Customer'}</th>
		      <th>#{sortable 'subject', 'Subject'}</th>"
		      if object
			      if object.first.class == Request
			      	html += "<th>Urgency</th>"
			      end
			  end
		      if publication
		      	html += "<th>Date of Publication</th>"
		      end
		      html += "<th>Notes</th>
		      <th>#{sortable 'agent_id', 'Agent'}</th>
		      <th></th>
		      <th></th>
		    </tr>
		  </thead>

		  <tbody>"
		  if object != nil
		    object.each do |obj|
				delaycss = ""
				if obj.class == Order
				    obj.positions.each do |p|
				      if p.deliverydate
				        if p.deliverydate < DateTime.now.to_date
				          delaycss = "delayed"
				        end
				      end
				    end
				end
		      html += "
		      <tr class='#{delaycss}'>
		        <td>#{obj.customer.email}</td>
		        <td>#{obj.subject}</td>"
		      if obj.class == Request
		        html += "<td>"
		          if obj.urgency == 1 
		             html += "uncritical<div class='circle circle-green circle-small'></div>"
		          elsif obj.urgency == 2
		            html += "medium<div class='circle circle-small'></div>"
		          else
		            html += "critical<div class='circle circle-red circle-small'></div>"
		          end
		          html += "</td>
		         </td>"
		      end
		      	if publication
		      		html += "<td>#{obj.publication}</td>"
		      	end
		        html += "<td>#{countNotes(obj)}</td>"
		        if obj.agent
		          html += "<td>#{obj.agent.email}</td>"
		        else
		        	html += "<td></td>"
		        end

		        if editlink
		        	html += "<td><a href='#{showpath}/#{obj.id}/edit' class='btn btn-info'>Edit</a> </td>"
		        else
		        	html += "<td><a href='#{showpath}/#{obj.id}' class='btn btn-info'>Show</a> </td>"
		    	end
		    	if assumable
		    		if obj.agent == current_user
		    			html += "<td><a href='#{showpath}/#{obj.id}/release' class='btn btn-danger'>Release</a> </td>"
		    		else
		    			html += "<td><a href='#{showpath}/#{obj.id}/assume' class='btn btn-success'>Assume</a> </td>"
		    		end
		    	end
		      html += "</tr>"
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

	def showObject(object, noteButton, request, positions=false, sum=false, pdf=false, format = "")
		path=getObjectPath(object)

		html ="<center><h1>#{object.class}</h1></center>"

		if object.class == Request
			 if object.urgency == 1 
	           html += "<center><table><tr><td><h1>uncritical</h1></td><td><div class='circle circle-green'></div></td></tr></table></center>"
	         elsif object.urgency == 2
	          html += "<center><h1>medium</h1></center><div class='circle'></div>"
	         else 
	          html += "<center><h1>critical</h1></center><div class='circle circle-red'></div>"
	         end 
		end

		html += "<div class='row'><div class='thumbnail span5'>
		<p>
		  <strong>Subject:</strong>
		  #{object.subject}
		</p>

		<p>
		  <strong>Body:</strong>
		  #{object.body}
		</p>"
		if sum
			if object.installationprice
				html += "<p>
				  <strong>Installationprice:</strong>
				  #{object.installationprice} €
				</p></div>"
			end
		end	
			
		html += "<div class='thumbnail span5 pull-right'>
		<p>
		  <strong>Name:</strong>
		  #{object.customer.firstname} #{object.customer.lastname}
		</p>
		<p>
		  <strong>Email:</strong>
		  #{object.customer.email}
		</p>
		<p>
		  <strong>Phone:</strong>
		  #{object.customer.phone}
		</p>
		<p>
		  <strong>Street:</strong>
		  #{object.customer.street}
		</p>
		<p>
		  <strong>Zip:</strong>
		  #{object.customer.zip}
		</p>"

		html += "</div></div>"
		if positions
			html += show_positions(object)
		end
		if format =="pdf"
			html += "<div style='display: none;'>"
		end
		html += show_notes(request, noteButton, object.id)
		if format =="pdf"
			html += "</div></div>"
		end
		if sum
			html += "<h3>Total: #{calcTotalPrice(object)} €</h3>"
		end

		if pdf and format != "pdf"
			html += "<a href='#{path}/#{object.id}.pdf' class='btn btn-info'>Create PDF document</a>"
		end
		return html
	end

	def getObjectPath(object)
		if object
		    if object.class == Request
		    	showpath = requests_path
		    elsif object.class == Offer
		    	showpath = offers_path
		    elsif object.class == Assignment
		    	showpath = assignments_path
		    elsif object.class == Order
		    	showpath = orders_path
		    elsif object.class == Installation
		    	showpath = installations_path
		    elsif object.class == Invoice
		    	showpath = invoices_path
		    end
		end

		return showpath
	end

end