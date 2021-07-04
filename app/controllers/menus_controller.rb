class MenusController < ApplicationController

  def index
    menus = current_user.menus.order(date: :DESC)
    @menus = Kaminari.paginate_array(menus).page(params[:page]).per(9)
  end

  def new
    @menu = Menu.new
    @menu_recipe = MenuRecipe.new
  end

  def create
    @menu = current_user.menus.new(menu_params)
    menu_recipe = MenuRecipe.new
    if @menu.save
      menu_recipe.menu_id = @menu.id
      menu_recipe.recipe_id = params[:menu][:recipe_id]
      menu_recipe.save
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


