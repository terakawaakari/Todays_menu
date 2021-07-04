class RecipesController < ApplicationController

  def index
    @recipes = Recipe.page(params[:page]).per(15)
  end

  def my_recipe
    @my_recipes = current_user.recipes
  end

  def show
    @recipe = Recipe.find(params[:id])
    @ingredients = @recipe.ingredients
    @directions = @recipe.directions
  end

  def new
    @recipe = Recipe.new
    @ingredients = @recipe.ingredients.new
    @directions = @recipe.directions.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    @directions = @recipe.directions
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @ingredients = @recipe.ingredients
    @directions = @recipe.directions
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.directions.destroy_all
    @recipe.ingredients.destroy_all
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe)
    else
      @ingredients = @recipe.ingredients
      render :edit
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect_to my_recipe_path
  end

  def recommend
  end


  private
  def recipe_params
    params.require(:recipe).permit(
      :name, :recipe_image, :serving, :genre, :category, :taste, :time, :popularity, :url, :note, :is_open,
      ingredients_attributes:[:name, :quantity, :_destroy],
      directions_attributes:[:description, :_destroy]
    )
  end
end
