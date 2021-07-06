class UsersController < ApplicationController

  def show
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user), notice: "変更を保存しました"
    end
  end

  def edit
  end

  def withdraw
    current_user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end

end
