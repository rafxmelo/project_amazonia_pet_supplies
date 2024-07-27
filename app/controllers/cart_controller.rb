class CartController < ApplicationController
  before_action :authenticate_user!
  def show
    @cart = session[:cart] || {}
    @products = Product.where(id: @cart.keys)
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
    id = params[:id].to_i
    cart = session[:cart] || {}
    cart[id] ? cart[id] += 1 : cart[id] = 1
    session[:cart] = cart
    redirect_to cart_path
  end


  def update
    id = params[:id].to_i
    quantity = params[:quantity].to_i
    cart = session[:cart] || {}

    Rails.logger.debug "Update action called with params: #{params.inspect}"
    Rails.logger.debug "Cart before update: #{cart.inspect}"

    if cart[id] && quantity > 0
      cart[id] = quantity
    elsif cart[id] && quantity <= 0
      cart.delete(id)
    end

    session[:cart] = cart

    Rails.logger.debug "Cart after update: #{cart.inspect}"

    redirect_to cart_path
  end

  def remove
    id = params[:id].to_i
    cart = session[:cart] || {}

    Rails.logger.debug "Remove action called with params: #{params.inspect}"
    Rails.logger.debug "Cart before remove: #{cart.inspect}"

    if cart.key?(id)
      cart.delete(id)
      Rails.logger.debug "Item removed successfully."
    else
      Rails.logger.debug "Item not found in cart."
    end

    session[:cart] = cart

    Rails.logger.debug "Cart after remove: #{cart.inspect}"
    redirect_to cart_path
  end
end
