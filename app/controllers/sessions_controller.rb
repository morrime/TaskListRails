class SessionsController < ApplicationController
skip_before_action :require_login, only: [:create]

  def index
    if session[:user_id].nil?
      redirect_to root_path
    else
      @user = User.find(session[:user_id])
    end
  end


  def create
    auth_hash = request.env['omniauth.auth']
    redirect to root_path unless auth_hash['uid']
    @user = User.find_by(uid: auth_hash[:uid], provider: 'github')
    if @user.nil?
      # User doesn't match anything in the DB.
      # Attempt to create a new user.
      @user = User.build_from_github(auth_hash)
      render :creation_failure unless @user.save
    end
    session[:user_id] = @user.id
    redirect_to sessions_path
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end

end
