class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user_has_province, only: [:new, :create]

  def index
    @orders = current_user.orders
  end

  def new
    @order = Order.new(user: current_user)
    if session[:cart].present?
      @order.add_items_from_cart(session[:cart])
      if params[:province_id].present?
        @order.user.province_id = params[:province_id]
        @order.calculate_total_amount
      else
        @order.user.province_id = current_user.province_id if current_user.province_id.present?
        @order.calculate_total_amount
      end
      Rails.logger.debug "Order items in new action: #{@order.order_items.inspect}"
    end
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.add_items_from_cart(session[:cart])
    @order.status = 'pending' # Set a default status
    Rails.logger.debug "Order before saving: #{@order.inspect}"
    if @order.save
      session[:cart] = {}
      flash[:notice] = 'Order placed successfully'
      redirect_to @order, notice: 'Order was successfully created.'
    else
      Rails.logger.debug "Order save failed: #{@order.errors.full_messages}"
      flash[:alert] = 'Failed to place the order. Please try again.'
      render :new
    end
  end

  def recalculate_total
    province = Province.find(params[:province_id])
    @order = Order.new(user: current_user)
    @order.add_items_from_cart(session[:cart]) if session[:cart].present?
    @order.user.province = province
    @order.calculate_total_amount

    respond_to do |format|
      format.json { render json: { total_amount: @order.total_amount } }
    end
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:total_amount, :status, :province_id, order_items_attributes: [:product_id, :quantity, :price])
  end

  def ensure_user_has_province
    unless current_user.province
      redirect_to edit_user_registration_path, alert: 'Please update your profile with your province before placing an order.'
    end
  end
end
