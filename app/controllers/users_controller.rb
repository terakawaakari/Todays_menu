class UsersController < ApplicationController

  before_action :confirm_user,  except: [:index]
  before_action :confirm_admin, only:   [:index]

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

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: "強制退会を実行しました"
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :birth_date, :sex, :is_deleted)
  end

  def confirm_user
    unless params[:id] == current_user.id || current_user.admin?
      redirect_to recipes_path
    end
  end

  def confirm_admin
    unless current_user.admin?
      redirect_to recipes_path
    end
  end

end
