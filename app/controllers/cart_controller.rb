class CartController < ApplicationController
  def show
    @cart = session[:cart] || {}
  end

  def add
    id = params[:id].to_i
    cart[id] ? cart[id] += 1 : cart[id] = 1
    session[:cart] = cart
    redirect_to cart_path
  end

  def remove
    id = params[:id].to_i
    cart.delete(id)
    session[:cart] = cart
    redirect_to cart_path
  end

  private

  def cart
    session[:cart] ||= {}
  end
end
