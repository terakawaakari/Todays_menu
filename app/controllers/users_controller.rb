class UsersController < ApplicationController

  before_action :redirect_referrer, only: [:index]

  def index
    @users = User.all
  end

  def show
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user), notice: "変更を保存しました"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def withdraw
    
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :birth_date, :sex, :is_deleted)
  end

  def redirect_referrer
    redirect_to request.referrer unless current_user.admin?
  end

end
