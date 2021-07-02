class RecipesController < ApplicationController

  def index
    @recipes = Recipe.page(params[:page]).per(15)
  end

  def my_recipe
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def edit
  end

  def recommend
  end

end
