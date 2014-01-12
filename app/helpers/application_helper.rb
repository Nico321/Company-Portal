module ApplicationHelper

	def show_notes(request)
		nrOfNotes = request.notes.count
		if request.offer
			nrOfNotes += request.offer.notes.count
		end

		html = "
				<div class='accordion' id='accordion2'>
				    <div class='accordion-group'>
				      <div class='accordion-heading'>
				        <a class='accordion-toggle' data-toggle='collapse' data-parent='#accordion2' href='#collapseOne'>
				        Notes(#{nrOfNotes})
				        </a>
				      </div>
				      <div id='collapseOne' class='accordion-body collapse'>
				        <div class='accordion-inner'>"
						request.notes.each do |n|				          
		html += "
							<div class='accordion-group requestnote' data-parent='#collapseOne'>
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
						if request.offer
							request.offer.notes.each do |n|				          
		html += "
								<div class='accordion-group offernote' data-parent='#collapseOne'>
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
						end
		if request.offer				
			html +=	"		<div style='float: right;'>#{link_to 'Add a note', new_note_path(:offer_id => request.offer.id), :class => 'btn btn-primary'}</div>"
		else
			html +=	"		<div style='float: right;'>#{link_to 'Add a note', new_note_path(:request_id => request.id), :class => 'btn btn-primary'}</div>"
		end
		
		html +="		</div>
				      </div>
				    </div>
				</div>
						"
				

		return html
	end
end



