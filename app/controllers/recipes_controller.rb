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
    @ingredients = @recipe.ingredients.new
    @directions = @recipe.directions.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    @directions = @recipe.directions
    @directions.each.with_index(1) do |direction, num|
      direction.number = num
    end
    if @recipe.save
      redirect_to recipes_path
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
    @directions = Recipe.new(recipe_params).directions
    @directions.each.with_index(1) do |direction, num|
      direction.number = num
    end
    @recipe.directions = @directions
    if @recipe.save
      redirect_to recipes_path
    else
      @ingredients = @recipe.ingredients
      render :edit
    end
  end



  def recommend
  end


  private
  def recipe_params
    params.require(:recipe).permit(
      :name, :recipe_image, :serving, :genre, :category, :taste, :time, :popularity, :url, :note, :is_open,
      ingredients_attributes:[:name, :quantity, :_destroy],
      directions_attributes:[:description, :process_image, :_destroy]
    )
  end
end
