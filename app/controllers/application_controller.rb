class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :sign_out_banned_user

  # store actual page before login to redirect to this page after login
  before_action :store_user_location!, if: :storable_location?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :initialize_component_context
  before_action :set_locale

  include Pundit::Authorization

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Raise an alert if not authorized
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def sign_out_banned_user
    return unless current_user&.banned?

    sign_out current_user
    redirect_to root_path, alert: "Ce compte a été suspendu pour violation des conditions générales d'utilisation."
  end

  def initialize_component_context
    Current.user = current_user
  end

  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end

  def after_sign_up_path_for(resource)
    stored_location_for(resource) || root_path
  end

  def user_not_authorized
    flash[:alert] = "Vous n'êtes pas autorisé à effectuer cette action."
    redirect_to(root_path)
  end

  # vérifie que la page peut être stocker pour ne pas tomber dans une boucle de redirection infinie
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def default_url_options
    { host: ENV['DOMAIN'] || "localhost:3000" } # rajouter le nom de domaine en prod
  end

  # equivalent a user_params (qu'est-ce qu'on autorise a etre modifie)
  def configure_permitted_parameters
    # lors de la creation d'un nouveau compte
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(
        :email,
        :password,
        :password_confirmation,
        :first_name,
        :last_name,
        :avatar,
        :role,
        :pseudo
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
        :last_name,
        :avatar,
        :role,
        :pseudo
      )
    end
  end
end
