class BookmarksController < ApplicationController

  def create
    recipe = Recipe.find(params[:recipe_id])
    bookmarks = current_user.bookmarks.new(recipe_id: recipe.id)
    bookmarks.save
    redirect_to request.referrer
  end

  def destroy
    recipe = Recipe.find(params[:recipe_id])
    bookmarks = current_user.bookmarks.find_by(recipe_id: recipe.id)
    bookmarks.destroy
    redirect_to request.referrer
  end

end
