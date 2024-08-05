class ProductsController < ApplicationController

  def index
    @q = Product.ransack(params[:q])
    @products = @q.result.page(params[:page]).per(10)

    if params[:filter] == "on_sale"
      @products = @products.on_sale
    elsif params[:filter] == "newly_added"
      @products = @products.newly_added
    elsif params[:filter] == "recently_updated"
      @products = @products.recently_updated
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
