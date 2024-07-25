class HomeController < ApplicationController
  def index
    @products = Product.limit(5)
    @on_sale_products = Product.on_sale
    @new_products = Product.newly_added
    @recently_updated_products = Product.recently_updated
    @categories = Category.all
  end

  def search
    @categories = Category.all
    if params[:category_id].present?
      @products = Category.find(params[:category_id]).products.search(params[:keyword])
    else
      @products = Product.search(params[:keyword])
    end
    render :search
  end
end
