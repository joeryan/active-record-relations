class SessionsController < ApplicationController
  skip_before_action :ensure_login, only: [:new, :create]
  
  def new
  end

  def create
    @username = params[:user][:username]
    @password = params[:user][:password]

    if (@user = User.find_by(username: @username)) && @user.authenticate(@password)
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Logged in successfully"
    else
      redirect_to login_path, alert: "Username and/or password incorrect"
    end
  end

  def destroy
    reset_session
    redirect_to login_path, notice: "Successful logout"
  end
end
