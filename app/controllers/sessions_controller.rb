class SessionsController < ApplicationController
  def new
  end

  def create
    username = params[:user][:username]
    password = params[:user][:password]
    @user = User.find_by_credentials(username, password)

    if @user
      login!(@user)
      redirect_to users_url
    else
      render :new
    end
  end

  def destroy
    logout!
    redirect_to users_url
  end
end
