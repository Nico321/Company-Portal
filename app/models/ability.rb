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
				can :manage, :all 
			elsif user.has_role?(:accountant)
				can :read, :all, :except => [Bugreport]
				can :manage, Invoice
				cannot :destroy, Invoice
				can :index, Archive
				can :show, User
				can :list, User
			elsif user.has_role?(:technician)
				can :manage, Request
				cannot :destroy, Request
				can :manage, Installation
				cannot :destroy, Installation
				cannot :create, Installation
				can :index, Archive
				can :manage, Bugreport
				cannot :destroy, Bugreport
				can :convert, Invoice
				can :show, User
				can :list, User
			elsif user.has_role?(:customer)
				can :read, :all, :customer => user
				can :create, Request
				can :accept, Offer, :customer => user
				can :decline, Offer, :customer => user
				cannot :manage, Reporting
				cannot :index, Archive
				can :convert, Assignment
				can :show, User
				can :list, User
			elsif user.has_role?(:sales)   
				can :manage, :all
				cannot :destroy, :all
				cannot :manage, Reporting
				cannot :assume, Installation
				cannot :assumed, Installation
				cannot :unassumed, Installation
				cannot :convert, Invoice
				cannot :manage, Bugreport
				can :create, Bugreport
				can :show, User
				can :list, User
			else 
				user.add_role(:customer)
				user.save       
			end 
		end
	end
end  

