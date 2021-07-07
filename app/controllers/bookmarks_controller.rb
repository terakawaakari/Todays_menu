class BookmarksController < ApplicationController

  def index
    @bookmarks = current_user.bookmarks
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    bookmarks = current_user.bookmarks.new(recipe_id: @recipe.id)
    bookmarks.save
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    bookmarks = current_user.bookmarks.find_by(recipe_id: @recipe.id)
    bookmarks.destroy
  end

end
