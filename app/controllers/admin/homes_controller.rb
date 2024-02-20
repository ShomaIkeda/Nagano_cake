class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
   def top
    @orders = Order.includes(:order_details).page(params[:page])
   end
  


end
