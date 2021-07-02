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
    if @recipe.save
      redirect_to recipes_path
    else
      render :new
    end
  end

  def edit
  end

  def recommend
  end


  private
  def recipe_params
    params.require(:recipe).permit(
      :user_id, :name, :recipe_image, :serving, :genre, :category, :taste, :time, :popularity, :url, :note, :is_open,
      ingredients_attributes:[:name, :quantity, :_destroy],
      directions_attributes:[:description, :process_image, :number, :_destroy]
    )
  end
end
