### app/controllers/home_controller.rb ###
class HomeController < ApplicationController
  def index
    @products = Product.limit(5)
  end
end
