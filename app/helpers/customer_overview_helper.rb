module CustomerOverviewHelper
	def generateTableRow(object, progress, barstyle)
		html =""
		object.each do |obj|
			html += "<tr><td>#{obj.subject}</td>
			<td>#{obj.class}</td>
			<td>#{countNotes(obj)}</td>
			<td>
			<div class='progress progress-striped active #{barstyle}'>
    			<div class='bar' style='width: #{progress}%;'></div>
    			</div></td>
    		<td><a href='#{getObjectPath(obj)}/#{obj.id}' class='btn btn-info'>Show</a></td>
			</tr>"
		end
		return html
	end
end
