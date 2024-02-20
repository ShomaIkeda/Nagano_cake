class Public::CustomersController < ApplicationController

  before_action :authenticate_customer!
  def show
    @customer = current_customer
  end

  def edit
  @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customer_my_page_path
      flash[:notice] = "登録情報を更新しました。"
    else
      render :edit
    end
  end



  def confirm
  end

  def withdraw
     @customer = Customer.find(params[:id])
    @customer.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to top_path
  end


 private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :telephone_number, :email, :address, :is_active)
  end
end