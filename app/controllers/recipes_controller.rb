class RecipesController < ApplicationController

  def index
    @recipes = Recipe.page(params[:page]).per(15)
    @tags = Tag.all
  end

  def my_recipe
    @my_recipes = current_user.recipes
  end

  def show
    @recipe = Recipe.find(params[:id])
    @ingredients = @recipe.ingredients
    @directions = @recipe.directions
    @tags = @recipe.tags
  end

  def new
    @recipe = current_user.recipes.new
    @ingredients = @recipe.ingredients.new
    @directions = @recipe.directions.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    tags = params[:recipe][:tag_name].split(nil)
    if @recipe.save
      @recipe.save_tag(tags)
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
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
