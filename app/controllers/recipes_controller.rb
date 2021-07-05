class RecipesController < ApplicationController

  def index
    @recipes = Recipe.where(is_open: true).page(params[:page]).per(15)
    @tags = Tag.all
  end

  def my_recipe
    @my_recipes = current_user.recipes
    @my_recipes.each do |recipe|
      @tags = recipe.tags
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @ingredients = @recipe.ingredients
    @ingredients.each do |i|
      @ingredient = i
    end
    @directions = @recipe.directions
    @directions.each do |d|
      @direction = d
    end
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
    @tags = @recipe.tags.pluck(:tag_name).join(" ")
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.directions.destroy_all
    @recipe.ingredients.destroy_all
    tags = params[:recipe][:tag_name].split(nil)
    if @recipe.update(recipe_params)
      @recipe.save_tag(tags)
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

  def tag_search
    @tags = Tag.all
    @tag = Tag.find(params[:tag_id])
    @recipes = @tag.recipes
  end

  def recommend
  end


  private
  def recipe_params
    params.require(:recipe).permit(
      :name, :recipe_image, :serving, :genre, :category, :taste, :time, :url, :popularity, :note, :is_open,
      ingredients_attributes:[:name, :quantity, :_destroy],
      directions_attributes:[:description, :_destroy]
    )
  end
end
