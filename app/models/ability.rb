class Ability
	include CanCan::Ability

	def initialize(user)
		can :convert_from_cart, Assignment
		#user ||=User.new # guest user
		if user.present?
			can :create,  Bugreport
			can :create, Note
			can :read, Note   

		# issue with the admin role doesn't get the right role if not commentend
		# everyone has role :admin
			if user.has_role?(:superadmin)
			#Admin    
			can :manage, :all 
			elsif user.has_role?(:accountant)
				can :read, :all, :except => [Bugreport]
				can :edit, Invoice
				can :open, Invoice
				can :index, Archive
			elsif user.has_role?(:technician)
				can :manage, Installation
				cannot :destroy, Installation
				cannot :create, Installation
				can :index, Archive
				can :manage, Bugreport
				cannot :destroy, Bugreport
				can :manage, Invoice
				cannot :destroy, Invoice
			elsif user.has_role?(:customer)
				can :read, :all, :customer => user
				can :create, Request
				can :accept, Offer, :customer => user
				can :decline, Offer, :customer => user
				cannot :manage, Reporting
				cannot :index, Archive
				can :convert, Assignment
			elsif user.has_role?(:sales)   
				can :manage, :all
				cannot :destroy, :all
				cannot :manage, Reporting
				cannot :assume, Installation
				cannot :assumed, Installation
				cannot :unassumed, Installation
				cannot :convert, Invoice
			else 
				user.add_role(:customer)
				user.save       
			end 
		end
	end
end  

