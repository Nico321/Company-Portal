class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

after_filter :user_activity

# added because of use of cancan 1.6 and use if rails 4.0
before_filter do
  resource = controller_name.singularize.to_sym
  method = "#{resource}_params"
  params[resource] &&= send(method) if respond_to?(method, true)
end


rescue_from CanCan::AccessDenied do |exception|
  flash[:error] = "Access denied."
  redirect_to root_url
end

private

def user_activity
  current_user.try :touch
end

def authenticate_admin_user!
	redirect_to new_user_session_path unless current_user && 
	current_user.has_role?(:admin)
end
  
end
