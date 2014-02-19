class Ability
  include CanCan::Ability

  def initialize(user)

	user ||=User.new # guest user
 
	if user.present?
	  
          	can :assumed, Bugreport
                can :create,  Bugreport
  		can :open, Bugreport
                
     		
	   #sales
           if user.has_role?(:sales)   
	      	can :manage, Offer
	      	can :manage, Order
	      	can :manage, Note
   	      	can :manage, Article
	      	can :manage, Request
              	can :manage, Supplier         
	        can :manage, Assignment

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
           end	

	   if user.has_role?(:customer)
		can :assumed, Request
                can :create,  Request
  		can :open, Request               	
           end

            # issue with the admin role doesn't get the right role if not commentend
            # everyone has role :admin

             if user.has_role?(:admin)
	    #Admin    
	    can :manage, :all           
	     end
	

	   #  else
           #   Registered users
           #   can? :read, :all                   
         end

end  

