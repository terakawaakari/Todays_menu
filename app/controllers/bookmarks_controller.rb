class BookmarksController < ApplicationController

  before_action :set_q, only: [:index, :bookmark_search]

  def index
    @bookmarks = current_user.bookmarks.order(created_at: :DESC).page(params[:page]).per(15)
    @tags      = RecipeTag.joins(:tag).where(recipe_id: @bookmarks.pluck(:recipe_id)).select('tags.tag_name').distinct
  end

  def create
    @recipe   = Recipe.find(params[:recipe_id])
    bookmarks = current_user.bookmarks.new(recipe_id: @recipe.id)
    bookmarks.save
  end

  def destroy
    @recipe   = Recipe.find(params[:recipe_id])
    bookmarks = current_user.bookmarks.find_by(recipe_id: @recipe.id)
    bookmarks.destroy
  end

  def bookmark_search
    @results   = @q.result.order(created_at: :DESC).page(params[:page]).per(15)
    @bookmarks = current_user.bookmarks
    @tags      = RecipeTag.joins(:tag).where(recipe_id: @bookmarks.pluck(:recipe_id)).select('tags.tag_name').distinct
  end

  private

  def set_q
    @q = Recipe.where(id: current_user.bookmarks.pluck(:recipe_id)).ransack(params[:q])
  end
end
