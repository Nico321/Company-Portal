class UserController < ApplicationController

	# proplem with NameError in UserController#index when load_and_authorize_resource is implemented
	# also when implemented in link restrictions
	load_and_authorize_resource

	def show
		@user = User.where("firstname like '%#{params[:name]}%'")
		if  User.where("firstname like '%#{params[:name]}%'").count == 0
			redirect_to root_path
		else
			@user = @user.first
			if @user.current_sign_in_ip != nil 
				@online = '<div class="circle circle-green circle-small"><div>'
			 else
			 	@online = '<div class="circle circle-red circle-small"><div>'
			end
		end
	end

end