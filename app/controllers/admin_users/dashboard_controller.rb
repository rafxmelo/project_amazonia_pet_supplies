# app/controllers/admin/dashboard_controller.rb
class Admin::DashboardController < ApplicationController
  before_action :authenticate_admin_user!

  def index

  end
end
