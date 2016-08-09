class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    un, pw = params[:user][:username], params[:user][:password]

    @user = User.find_by_credentials(un, pw)

    if @user
      login(@user)
      redirect_to goals_url
    else
      flash.now[:errors] = ["Invalid username or password"]
      render :new
    end
  end

  def destroy
    logout
    redirect_to new_session_url
  end
end
