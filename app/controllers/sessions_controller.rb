class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:username])
    if !@user.nil? && @user.password == params[:password]
      session[:user_id] = @user.id
      redirect_to :root
    else
      redirect_to login_path
    end
  end

  def destroy
    reset_session
    redirect_to :root
  end
end
