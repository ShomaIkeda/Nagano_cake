class Public::CartItemsController < ApplicationController

  before_action :authenticate_customer!

  def index
     @cart_items = current_customer.cart_items
  end

  def create
    @cart_item = current_customer.cart_items.new(cart_items_params)
    if current_customer.cart_items.find_by(item_id: cart_items_params[:item_id])
      if cart_item_params[:amount].blank?
        @item = Item.find(cart_item_params[:item_id])
        @cart_item = CartItem.new
        flash[:notice] = "個数を入力してください"
        redirect_to item_path(@item.id)
      else
        @cart_item = current_customer.cart_items.find_by(item_id: cart_item_params[:item_id])
        @cart_item.amount = @cart_item.amount + cart_item_params[:amount].to_i
        @cart_item.save
        redirect_to cart_items_path
      end
    else
    
      if cart_items_params[:amount].blank?
        @item = Item.find(cart_items_params[:item_id])
        @cart_item = CartItem.new
        flash[:notice] = "個数を入力してください"
        redirect_to item_path(@item.id)
      else
        @cart_item = current_customer.cart_items.new(cart_items_params)
        @cart_item.save
        redirect_to cart_items_path
      end
    end
  end


  def update
     @cart_item = CartItem.find(params[:id])
     @cart_item.amount = params[:cart_item][:amount]

    if @cart_item.save
     redirect_to cart_items_path, notice: 'カート内の商品の個数を更新しました。'
    else
     redirect_to cart_items_path, alert: 'カート内の商品の個数を更新できませんでした。'
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])

    if @cart_item.destroy
      redirect_to cart_items_path, notice: 'カート内用品を削除しました'
    else
      redirect_to cart_items_path, alert: 'カート内の商品を削除できませんでした'
    end
  end


  def destroy_all
   current_customer.cart_items.destroy_all
   redirect_to cart_items_path, notice: '全てのカートアイテムを削除しました'
  end



  private

  def cart_items_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end
end

