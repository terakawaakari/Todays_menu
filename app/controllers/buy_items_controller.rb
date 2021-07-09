class BuyItemsController < ApplicationController

  def index
    @items = current_user.buy_items
    @item  = current_user.buy_items.new
  end

  def create
    @item = current_user.buy_items.new(buy_item_params)
    @item.save
    redirect_to request.referrer
  end

  def update
    item = BuyItem.find(params[:id])
    item.update(buy_item_params)
    redirect_to buy_items_path
  end

  def destroy
    item = current_user.buy_items.find(params[:id])
    item.destroy
    redirect_to buy_items_path
  end

  def all_destroy
    current_user.buy_items.destroy_all
    redirect_to buy_items_path
  end

  def bought_destroy
    current_user.buy_items.where(is_bought: true).destroy_all
    redirect_to buy_items_path
  end

  private
  def buy_item_params
    params.require(:buy_item).permit(:name, :is_bought)
  end

end