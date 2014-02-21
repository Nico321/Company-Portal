class Ability
  include CanCan::Ability

  def initialize(user)

	user ||=User.new # guest user
 
	if user.present?
	  
          	can :assumed, Bugreport
                can :create,  Bugreport
  		can :open, Bugreport
		can :show, Bugreport

           if user.has_role(nil)
   		user.add_role :customer
           end     
     		
	   #sales
           if user.has_role?(:sales)   
	      	can :manage, Offer
	      	can :manage, Order
	      	can :manage, Note
   	      	can :manage, Article
	      	can :manage, Request
              	can :manage, Supplier         
	        can :manage, Assignment
		can :manage, Invoice
                can :open, Installation

           end
           
           end

	   #Accounting
	   if user.has_role?(:accountend)
	   	can :manage, Assignment              	
	   end

	   #Technican
   	   if user.has_role?(:technican)
		can :manage, Assignment
		can :manage, Bugreport  
		can :manage, Installation              	
           end	

	   if user.has_role?(:customer)
		can :assumed, Request
                can :create,  Request
  		can :open, Request  
                can :show, Request 
		can :read, Invoice   
		can :open, Installation
  		can :manage, Note          	
           end

            # issue with the admin role doesn't get the right role if not commentend
            # everyone has role :admin

           if user.has_role?(:superadmin)
	    #Admin    
	    can :manage, :all           
	   end
	

	   #  else
           #   Registered users
           #   can? :read, :all                   
         end

end  

