class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.add_items_from_cart(session[:cart])
    if @order.save
      session[:cart] = {}
      redirect_to @order, notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:total_amount, :status, order_items_attributes: [:product_id, :quantity, :price])
  end
end
