class BuyItemsController < ApplicationController

  def index
    @items = current_user.buy_items
    @item  = current_user.buy_items.new
  end

  def create
    @items = current_user.buy_items
    @item = current_user.buy_items.new(buy_item_params)
    if request.referrer.include?("recipes")
      @item.save
      redirect_to request.referrer, notice: "買い物リストに「#{@item.name}」を追加しました"
    end
    if @item.save
      @item = current_user.buy_items.new
    else
      @items = current_user.buy_items
      render :index
    end
  end

  def update
    @items = current_user.buy_items
    item = BuyItem.find(params[:id])
    item.update(buy_item_params)
  end

  def destroy
    @items = current_user.buy_items
    item = current_user.buy_items.find(params[:id])
    item.destroy
  end

  def all_destroy
    @items = current_user.buy_items
    current_user.buy_items.destroy_all
  end

  def bought_destroy
    @items = current_user.buy_items
    current_user.buy_items.where(is_bought: true).destroy_all
  end

  private
  def buy_item_params
    params.require(:buy_item).permit(:name, :is_bought)
  end

end
