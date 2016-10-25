class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :logged_in?

  private

  def logged_in?
     redirect_to login_path if session[:user_id].nil?
  end

 def current_user
   begin
     @current_user ||= User.find(session[:user_id]) if session[:user_id]
   rescue ActiveRecord::RecordNotFound
     nil
   end
 end
end
