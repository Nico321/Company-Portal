class UserController < ApplicationController

	# proplem with NameError in UserController#index when load_and_authorize_resource is implemented
	# also when implemented in link restrictions
	load_and_authorize_resource

	def show
		@user = User.find(params[:id])

			if @user.current_sign_in_ip != nil 
				@online = '<div class="circle circle-green circle-small"><div>'
			 else
			 	@online = '<div class="circle circle-red circle-small"><div>'
			end
	end

	def list
		list = Hash.new
			User.where("firstname like '%#{params[:name]}%'").each do |user|
				list[user.id] = user
			end
			User.where("lastname like '%#{params[:name]}%'").each do |user|
				list[user.id] = user
			end
			User.where("email like '%#{params[:name]}%'").each do |user|
				list[user.id] = user
			end
		@list = list
	end

	def changerole
		@user = User.find(params[:user_id])
	end

	def modifyrole
		@user = User.find(params[:user_id])
		@role = Role.find(params[:Role])
		current_role = @user.roles.first
		@user.remove_role current_role.name
		@user.add_role @role.name
		@user.save

		redirect_to root_path, :notice => "#{@user.firstname} #{@user.lastname} is now #{@role.name}."
	end

end