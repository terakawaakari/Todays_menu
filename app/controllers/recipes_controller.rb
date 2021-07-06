class RecipesController < ApplicationController

  def index
    @recipes = Recipe.where(is_open: true).order(created_at: :DESC).page(params[:page]).per(15)
    @tags = Tag.all
  end

  def my_recipe
    @my_recipes = current_user.recipes
    @my_recipes.each do |recipe|
      @tags = recipe.tags
    end
  end

  def new
    @recipe = current_user.recipes.new
    @ingredients = @recipe.ingredients.new
    @directions = @recipe.directions.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    #既存のタグと新規タグを判別するため入力されたタグ名を配列に格納
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
    #編集フォームに表示させる値を取得
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
    #関連付いたレシピが存在しないタグを消去
    recipe.tags.each do |tag|
      recipe.destroy
      if tag.recipes.blank?
        tag.destroy
      end
    end
    redirect_to my_recipe_path
  end

  def tag_search
    @tags = Tag.all
    @tag = Tag.find(params[:tag_id])
    @recipes = @tag.recipes
  end

  def main_recommend
    main_recipes = Recipe.where(genre: @recipe.genre, category: "主菜")
    change_taste = main_recipes.where.not(taste: @recipe.taste)
    @recommend_main = change_taste.where('time < ?', (90 - @recipe.time.to_i)).find_by('popularity >= ?', 3.0)
  end

  def sub_recommend
    sub_recipes = Recipe.where(genre: @recipe.genre, category: "副菜")
    change_taste = sub_recipes.where.not(taste: @recipe.taste)
    @recommend_sub = change_taste.where('time < ?', (90 - @recipe.time.to_i)).find_by('popularity >= ?', 3.0)
  end

  def soup_recommend
    soup_recipes = Recipe.where(genre: @recipe.genre, category: "汁物")
    change_taste = soup_recipes.where.not(taste: @recipe.taste)
    @recommend_soup = change_taste.where('time < ?', (90 - @recipe.time.to_i)).find_by('popularity >= ?', 3.0)
  end

  def recommend
    @recipe = Recipe.find(params[:recipe_id])

    case @recipe.category
    when "主菜" || "主食"
      sub_recommend
      soup_recommend

    when "副菜"
      main_recommend
      soup_recommend

    when "汁物"
      main_recommend
      sub_recommend
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
    case @recipe.category
    when "主菜" || "主食"
      sub_recommend
      soup_recommend

    when "副菜"
      main_recommend
      soup_recommend

    when "汁物"
      main_recommend
      sub_recommend
    end
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
