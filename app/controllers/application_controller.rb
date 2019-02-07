class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

def get_current_user
  render json: current_user
end

 def current_user
   @current_user ||= User.find_by(id: session[:user_id])
 end

 def logged_in?
   current_user != nil
 end
end
