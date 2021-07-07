class RecipesController < ApplicationController

  before_action :set_q, only: [:index, :search, :show, :my_recipe]

  def index
    @recipes = Recipe.where(is_open: true).order(created_at: :DESC).page(params[:page]).per(15)
    @recipes.each do |recipe|
      @tags = recipe.tags
    end
  end

  def my_recipe
    @my_recipes = current_user.recipes.where(is_open: true)
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
    recommend_system
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
    @tag = Tag.find(params[:tag_id])
    @recipes = @tag.recipes.where(user_id: user.id, is_open: true)
    @recipes.each do |recipe|
      @tags = recipe.tags
    end
  end

  def recommend
    @recipe = Recipe.find(params[:recipe_id])
    recommend_system
  end

  def search
    @results = @q.result
  end

  private
  def recipe_params
    params.require(:recipe).permit(
      :name, :recipe_image, :serving, :genre, :category, :taste, :time, :url, :popularity, :note, :is_open,
      ingredients_attributes:[:name, :quantity, :_destroy],
      directions_attributes:[:description, :_destroy]
    )
  end

  def set_q
    @q = Recipe.where(is_open: true).ransack(params[:q])
  end

  #詳細ページのレシピと同じジャンル、異なるテイストの主菜のうち、合計調理時間が90分以内、人気度3以上のレシピを取得
  def main_recommend
    main_recipes = Recipe.where(genre: @recipe.genre, category: "主菜", is_open: true)
    change_taste = main_recipes.where.not(taste: @recipe.taste)
    @recommend_main = change_taste.where('time < ?', (90 - @recipe.time.to_i)).find_by('popularity >= ?', 3.0)
  end

  def sub_recommend
    sub_recipes = Recipe.where(genre: @recipe.genre, category: "副菜", is_open: true)
    change_taste = sub_recipes.where.not(taste: @recipe.taste)
    @recommend_sub = change_taste.where('time < ?', (90 - @recipe.time.to_i)).find_by('popularity >= ?', 3.0)

  end

  def soup_recommend
    soup_recipes = Recipe.where(genre: @recipe.genre, category: "汁物", is_open: true)
    change_taste = soup_recipes.where.not(taste: @recipe.taste)
    @recommend_soup = change_taste.where('time < ?', (90 - @recipe.time.to_i)).find_by('popularity >= ?', 3.0)
  end

  #詳細ページのレシピが主菜/主食→副菜と汁物、副菜→主菜と汁物、汁物→主菜と副菜のおすすめレシピを提案
  def recommend_system
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

end
