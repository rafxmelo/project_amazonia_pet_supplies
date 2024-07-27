class CartController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = session[:cart] || {}
    @products = Product.where(id: @cart.keys.map(&:to_i))
    Rails.logger.debug "Cart contents: #{@cart.inspect}"
    Rails.logger.debug "Products retrieved: #{@products.inspect}"

    @cart_items = @cart.map do |id, quantity|
      product = @products.find { |p| p.id == id.to_i }
      Rails.logger.debug "Processing product: #{product.inspect}" if product
      { product: product, quantity: quantity } if product
    end.compact
    Rails.logger.debug "Cart items: #{@cart_items.inspect}"
  end

  def add
    id = params[:id].to_s
    cart = session[:cart] || {}
    cart[id] ? cart[id] += 1 : cart[id] = 1
    session[:cart] = cart
    Rails.logger.debug "Cart after add: #{session[:cart].inspect}"
    redirect_to cart_path
  end

  def update
    cart_params = cart_update_params
    id = cart_params[:id].to_s
    quantity = cart_params[:quantity].to_i
    cart = session[:cart] || {}

    Rails.logger.debug "Update action called with params: #{params.inspect}"
    Rails.logger.debug "Cart before update: #{cart.inspect}"
    Rails.logger.debug "id for update: #{id}"
    Rails.logger.debug "quantity for update: #{quantity}"

    if cart.key?(id)
      if quantity > 0
        cart[id] = quantity
        Rails.logger.debug "Item updated successfully."
      else
        cart.delete(id)
        Rails.logger.debug "Item removed due to zero quantity."
      end
    else
      Rails.logger.debug "Item not found in cart. #{id}"
    end

    session[:cart] = cart

    Rails.logger.debug "Cart after update: #{session[:cart].inspect}"

    redirect_to cart_path
  end

  def remove
    cart_params = cart_remove_params
    id = cart_params[:id].to_s
    cart = session[:cart] || {}

    Rails.logger.debug "Remove action called with params: #{params.inspect}"
    Rails.logger.debug "Cart before remove: #{cart.inspect}"
    Rails.logger.debug "id for remove: #{id}"

    if cart.key?(id)
      cart.delete(id)
      Rails.logger.debug "Item removed successfully."
    else
      Rails.logger.debug "Item not found in cart. #{id}"
    end

    session[:cart] = cart

    Rails.logger.debug "Cart after remove: #{session[:cart].inspect}"
    redirect_to cart_path
  end

  private

  def cart_update_params
    params.permit(:id, :quantity, :_method, :authenticity_token, :commit)
  end

  def cart_remove_params
    params.permit(:id, :_method, :authenticity_token)
  end
end
