class SessionsController < ApplicationController

  skip_before_action :require_login, only: [:create, :login]

  def create
    auth_hash = request.env['omniauth.auth']
    redirect to login_path unless auth_hash['uid']
    @user = User.find_by(uid: auth_hash[:uid], provider: 'github')
    if @user.nil?
      @user = User.build_from_github(auth_hash)
      redirect_to login_path unless @user.save
    end

    session[:user_id] = @user.id

    redirect_to root_path
  end

  def login; end

  def show
    redirect_to login_path
  end

  def index
    @user = User.find(session[:user_id]) # < recalls the value set in a previous request
  end

  
  def logout
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_path
  end
end
