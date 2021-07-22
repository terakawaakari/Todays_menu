class MenusController < ApplicationController

  before_action :confirm_user, only: [:edit, :update, :destroy]
  before_action :set_q

  def index
    @menus = current_user.menus.order(date: :DESC).page(params[:page]).per(12)
    @menu_q = current_user.menus.ransack(params[:q])
  end

  def menu_sort
    @menu_q = current_user.menus.ransack(params[:q])
    @menus = @menu_q.result.page(params[:page]).per(12)
  end

  def calendar
    @menus = current_user.menus
  end

  def new
    @menu = current_user.menus.new
    @menu_recipes = @menu.menu_recipes.new
  end

  def create
    @menu = current_user.menus.new(menu_params)
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

  def set_q
    @q = Recipe.where(is_open: true).ransack(params[:q])
  end

  def confirm_user
    unless Menu.find(params[:id]).user_id == current_user.id || current_user.admin?
      redirect_to menus_path
    end
  end
end


