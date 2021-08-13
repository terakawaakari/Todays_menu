class RecipesController < ApplicationController

  before_action :confirm_user,   only:   [:edit, :update, :destroy]
  before_action :confirm_status, only:   [:show]
  before_action :find_recipe,    only:   [:show, :edit, :update, :destroy]
  before_action :set_q,          except: [:my_recipe, :my_search]
  before_action :my_q,           only:   [:my_recipe, :my_search]

  def index
    # 公開中のレシピを新着順に並べてページネート
    @recipes = Recipe.open_sort.page(params[:page]).per(12)
    # 公開中のレシピのタグを重複を省いて取得
    @tags    = unique_tags(@recipes)
  end

  def my_recipe
    @my_recipes = current_user.recipes.order(created_at: :DESC).page(params[:page]).per(12)
    @tags       = unique_tags(@my_recipes)
  end

  def new
    @recipe      = current_user.recipes.new
    @ingredients = @recipe.ingredients.new
    @directions  = @recipe.directions.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    # 既存のタグと新規タグを判別するため入力されたタグ名を配列に格納
    tags    = params[:recipe][:tag_name].split(nil)
    if @recipe.save
      @recipe.save_tag(tags)
      redirect_to recipe_path(@recipe), notice: "マイレシピを保存しました"
    else
      render :new
    end
  end

  def show
    @ingredients = @recipe.ingredients
    @directions = @recipe.directions
    @tags = @recipe.tags
    @item = current_user.buy_items.new
    recommend_system
  end

  def edit
    # 編集フォームに表示させる値を取得
    @tags = @recipe.tags.pluck(:tag_name).join(" ")
  end

  def update
    @recipe.directions.destroy_all
    @recipe.ingredients.destroy_all
    tags = params[:recipe][:tag_name].split(nil)
    if @recipe.update(recipe_params)
      @recipe.save_tag(tags)
      # レシピを非公開に更新した場合、紐づくブックマークを全て削除
      unless @recipe.is_open?
        @recipe.bookmarks.destroy_all
      end
      redirect_to recipe_path(@recipe), notice: "マイレシピを変更しました"
    else
      @ingredients = @recipe.ingredients
      render :edit
    end
  end

  def destroy
    if @recipe.destroy
      # 関連付いたレシピが存在しないタグを消去
      @recipe.tags.each do |tag|
        if tag.recipes.blank?
          tag.destroy
        end
      end
      redirect_to my_recipe_path, notice: "マイレシピを削除しました"
    else
      redirect_to my_recipe_path, alert: "削除に失敗しました　もう一度お試しください"
    end
  end

  def tag_search
    @tag        = Tag.find(params[:tag_id])
    @recipes    = @tag.recipes.open_sort.page(params[:page]).per(12)
    all_recipes = Recipe.open_sort
    @tags       = unique_tags(all_recipes)
  end

  def recommend
    @recipe = Recipe.find(params[:recipe_id])
    recommend_system
  end

  def search
    @results = @q.result.open_sort.page(params[:page]).per(12)
    @recipes = Recipe.where(is_open: true)
    @tags    = unique_tags(@recipes)
  end

  def my_search
    @results    = @q.result.order(created_at: :DESC).page(params[:page]).per(12)
    @my_recipes = current_user.recipes.where(is_open: true)
    @tags       = unique_tags(@my_recipes)
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :name, :recipe_image, :serving, :genre, :category, :taste, :time, :url, :popularity, :note, :is_open,
      ingredients_attributes: [:name, :quantity, :_destroy],
      directions_attributes:  [:description, :_destroy]
    )
  end

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def set_q
    @q = Recipe.where(is_open: true).ransack(params[:q])
  end

  def my_q
    @q = current_user.recipes.ransack(params[:q])
  end

  # 詳細ページのレシピと同じジャンル、異なるテイストの主菜のうち、合計調理時間が90分以内、人気度3以上のレシピを取得
  def main_recommend
    @recommend_main = Recipe.find_match_recipe(@recipe, "主食")
  end

  def main_dish_recommend
    @recommend_main_dish = Recipe.find_match_recipe(@recipe, "主菜")
  end

  def sub_recommend
    @recommend_sub = Recipe.find_match_recipe(@recipe, "副菜")
  end

  def soup_recommend
    @recommend_soup = Recipe.find_match_recipe(@recipe, "汁物")
  end

  # 詳細ページのレシピが主菜/主食→副菜と汁物、副菜→主菜と汁物、汁物→主菜と副菜のおすすめレシピを提案
  def recommend_system
    case @recipe.category
    when "主菜"
      sub_recommend
      soup_recommend
    when "主食"
      sub_recommend
      soup_recommend
    when "副菜"
      main_dish_recommend || main_recommend
      soup_recommend
    when "汁物"
      main_recommend || main_dish_recommend
      sub_recommend
    end
  end

  def confirm_user
    unless Recipe.find(params[:id]).user_id == current_user.id || current_user.admin?
      redirect_to recipes_path
    end
  end

  def confirm_status
    recipe = Recipe.find(params[:id])
    if recipe.user_id != current_user.id && !recipe.is_open? && !current_user.admin?
      redirect_to recipes_path
    end
  end

end
