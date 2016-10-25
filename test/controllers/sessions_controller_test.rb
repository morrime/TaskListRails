require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  skip_before_action :logged_in?, only: [:login, :create]

  def create
    auth_hash = request.env['omniauth.auth']
    redirect_to login_path unless auth_hash[:uid]
    @user = User.find_by(uid: auth_hash[:uid], provider: "github")
    if @user.nil?
      @user = User.create_from_github(auth_hash)
      redirect_to login_path unless @user.save
    end
    session[:user_id] = auth_hash[:uid]
    redirect_to root_path
  end

  def login; end

  def show
    redirect_to login_path
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end
end
