class MenusController < ApplicationController

  def index
    @menus = current_user.menus
  end

  def new
    @menu = Menu.new
  end

  def create
    @menu = Menu.new(menu_params)
    @menu.user_id = current_user.id
    if @menu.save
      redirect_to menus_path
    else
      render :new
    end
  end

  def show
    @menu = Menu.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def menu_params
    params.require(:menu).permit(:menu_image, :date, :category, :list)
  end

end


