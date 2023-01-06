class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :authenticate_user!

  private

  # equivalent a user_params (qu'est-ce qu'on autorise a etre modifie)
  def configure_permitted_parameters
    # lors de la creation d'un nouveau compte
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(
        :email,
        :password,
        :password_confirmation,
        :first_name,
        :last_name
      )
    end

    # lors de la modification d'un compte deja existant
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(
        :email,
        :password,
        :current_password,
        :password_confirmation,
        :first_name,
        :last_name
      )
    end
  end
end
