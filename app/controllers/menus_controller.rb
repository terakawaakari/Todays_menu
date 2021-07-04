class MenusController < ApplicationController

  def index
    @menus = current_user.menus
  end

  def new
  end
  
  def create
  end

  def show
  end

  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
end
