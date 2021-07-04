class MenusController < ApplicationController

  def index
    @menus = current_user.menus
  end

  def new
    @menu = Menu.new
  end

  def create
  end

  def show
    @menu = Menu.params([:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
