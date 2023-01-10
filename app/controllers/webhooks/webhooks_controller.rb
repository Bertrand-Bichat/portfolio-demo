class Webhooks::WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :skip_authorization
  skip_before_action :authenticate_user!

  protected

  def render_response(status)
    render json: { response: "received" }, status: status
  end
end
