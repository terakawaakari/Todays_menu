class MenusController < ApplicationController

  def index
    menus = current_user.menus.order(date: :DESC)
    @menus = Kaminari.paginate_array(menus).page(params[:page]).per(9)
  end

  def new
    @menu = current_user.menus.new
    @menu_recipes = @menu.menu_recipes.new
  end

  def create
    @menu = current_user.menus.new(menu_params)
    @menu_recipes = @menu.menu_recipes
    if @menu.save
      redirect_to menus_path
    else
      render :new
    end
  end

  def edit
    @menu = Menu.find(params[:id])
  end

  def update
    @menu = Menu.find(params[:id])
    @menu.menu_recipes.destroy_all
    if @menu.update(menu_params)
      redirect_to menus_path
    else
      render :edit
    end
  end

  def destroy
    menu = Menu.find(params[:id])
    menu.destroy
    redirect_to menus_path
  end

  private
  def menu_params
    params.require(:menu).permit(:menu_image, :date, :category, :list, menu_recipes_attributes: [:recipe_id, :_destroy])
  end
end


