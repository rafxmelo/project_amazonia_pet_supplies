# app/controllers/users/passwords_controller.rb
class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  def new
    super
  end

  # POST /resource/password
  def create
    super
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    super
  end

  # PUT /resource/password
  def update
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_reset_password_params
    devise_parameter_sanitizer.permit(:reset_password, keys: [:attribute])
  end
end
