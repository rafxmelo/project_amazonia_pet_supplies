class ApplicationController < ActionController::Base
  before_action :ensure_cart_session

  private

  def ensure_cart_session
    session[:cart] ||= {}
  end

  def route_not_found
    render plain: "Route not found: #{params[:path]}", status: 404
  end
end
