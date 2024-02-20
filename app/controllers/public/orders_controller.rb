class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @customer = current_customer
  end

  def confirm
    @customer = current_customer
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @postage = 800 
    @payment_method = params[:order][:payment_method]
    @order = Order.new
    @order.postal_code = params[:order][:postal_code]
    @order.name = params[:order][:name]
    @order.status = params[:order][:status]
    
   
    

    
    ary = []
    @cart_items.each do |cart_item|
    ary << cart_item.item.with_tax_price*cart_item.amount
  end
    @cart_items_price = ary.sum

    @total_amount = @postage + @cart_items_price
    
  end


  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @postage = 800
    @order.postal_code = params[:order][:postal_code] 

    @cart_items = CartItem.where(customer_id: current_customer.id)
      ary = []
    @cart_items.each do |cart_item|
      ary << cart_item.item.price_excluding_tax * cart_item.amount
  end
    @total_amount = ary.sum
    @order.amount = @postage + @total_amount
    @order.payment_method = params[:order][:payment_method]

 

  if @order.save
    if @order.status == 0
      @cart_items.each do |cart_item|
        OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, price_including_tax: cart_item.item.price_excluding_tax, quantity: cart_item.amount,  )  
      end
    else
      @cart_items.each do |cart_item|
        OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, price_price_including_tax: cart_item.item.price_excluding_tax, quantity: cart_item.amount,) 
      end
    end
      @cart_items.destroy_all
      redirect_to complete_path
    else
      render :items
    end
  end

  def index
    @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc).page(params[:page])
  end


  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
    @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc).page(params[:page])
    @customer = current_customer
    @postage = 800
  end


  private

  def order_params
    params.require(:order).permit(:customer_id, :payment_method, :amount, :postage, :postal_code, :name,:status)
  end
end