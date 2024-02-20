class Public::ItemsController < ApplicationController
  
  def index
    @items = Item.page(params[:page]).per(8) 
    @total_items_count = Item.count 
  end

  def show
    @cart_item = CartItem.new
    @item = Item.find(params[:id])
  end
  
  def item_params
    params.require(:item).permit(:name, :introduction, :price_excluding_tax, :image, :edit)
  end
  
  
end
