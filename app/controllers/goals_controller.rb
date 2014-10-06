class GoalsController < ApplicationController
  before_action :require_logged_in
  before_action :require_owner, only: [:edit, :update, :destroy]
  def new
  end

  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      redirect_to @goal
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def show
    @goal = Goal.find(params[:id])
    render :show
  end

  def edit
    @goal = current_user.goals.find(params[:id])
    render :edit
  end

  def update
    @goal = current_user.goals.find(params[:id])

    if @goal.update(goal_params)
      redirect_to @goal
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def destroy
    @goal = current_user.goals.find(params[:id])
    @goal.destroy!
    redirect_to user_url(current_user)
  end

  private
  def goal_params
    params.require(:goal)
      .permit(:title, :description, :private_goal, :completed)
  end

  def require_owner
    @goal = Goal.find(params[:id])
    unless current_user == @goal.user
      flash[:errors] = "Can't touch this"
      redirect_to goal_url(@goal)
    end
  end

end
