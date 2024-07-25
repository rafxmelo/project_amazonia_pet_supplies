# app/controllers/admin_users/sessions_controller.rb
class AdminUsers::SessionsController < Devise::SessionsController
  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    sign_out(current_admin_user)
    redirect_to root_path, notice: 'You have been logged out.'
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
