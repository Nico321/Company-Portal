class UserController < ApplicationController

	# proplem with NameError in UserController#index when load_and_authorize_resource is implemented
	# also when implemented in link restrictions
	load_and_authorize_resource

	def show
		#user = params[:search]
			@user = User.search(params[:firstname])
		if !@user.blank?
			@test = User.search(params[:firstname])
			@user = User.first
			if @user.current_sign_in_ip != nil 
				@online = '<div class="circle circle-green circle-small"><div>'
			 else
			 	@online = '<div class="circle circle-red circle-small"><div>'
			end
		end
	end
end