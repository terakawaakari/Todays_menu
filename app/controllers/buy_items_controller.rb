class BuyItemsController < ApplicationController

  def index
    @items = current_user.buy_items
    @item = current_user.buy_items.new
  end

  def create
    @item = current_user.buy_items.new(buy_item_params)
    @item.save
    redirect_to request.referrer
  end


  private
  def buy_item_params
    params.require(:buy_item).permit(:name, :is_bought)
  end

end
