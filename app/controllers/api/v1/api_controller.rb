class Api::V1::ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :doorkeeper_authorize!, unless: :signed_in_or_jwt?

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def signed_in_or_jwt?
    user_signed_in? || jwt_provided?
  end

  def jwt_provided?
    load_user
    return false if @user.blank?
    return false if object_in_token.blank?
    return true if @user&.id == user_in_token&.id
    return false unless object_in_token.respond_to?(:user_id)
    return true if @user&.id == object_in_token&.user_id

    false
  end

  def http_token
    @http_token ||= request.headers["x-jwt-token"]
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end

  def object_in_token
    @object_in_token ||= auth_token.present? ? GlobalID::Locator.locate(auth_token[:gid]) : nil
  end

  def user_in_token
    @user_in_token ||= auth_token.present? ? GlobalID::Locator.locate(auth_token[:user_gid]) : nil
  end

  def load_user
    @user = Current.user
  end

  def current_resource_owner
    @current_user ||= if doorkeeper_token
                        User.find(doorkeeper_token.resource_owner_id)
                      else
                        warden.authenticate(scope: :user)
                      end
  end
  helper_method :current_resource_owner

  def check_user_access!
    current_resource_owner # FIXME: doing this to set `current_user` when authenticated via Oauth2
    head(:unauthorized) unless user_user_access?(user: current_user, user: @user)
  end

  def user_user_access?(user: nil, user: nil)
    return false if user.blank?

    jwt_provided? || user&.membership_for(user).present?
  end
end
