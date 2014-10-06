class UsersController < ApplicationController
  before_action :require_logged_in, only: [:index, :show]

  def new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)
      redirect_to users_url
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end


  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end

