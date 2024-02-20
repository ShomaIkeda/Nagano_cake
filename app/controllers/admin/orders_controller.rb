class Admin::OrdersController < ApplicationController
  
  before_action :authenticate_admin!
  
  def index
    @items = Item.page(params[:page])
  end

  def show
    @order = Order.find(params[:id]) 
    @order_details = @order.order_details
    @payment_method = params[:order] ? params[:order][:payment_method] : nil
    @customer = @order.customer 
    @postage = 800
    @order

  end

private

  def order_params
    params.require(:order).permit(:customer_id, :payment_method, :amount, :postage, :postal_code, :address, :name)
  end
  
end
