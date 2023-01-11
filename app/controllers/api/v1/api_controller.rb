class Api::V1::ApiController < ActionController::Base
  skip_before_action :verify_authenticity_token
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  respond_to :json

  private

  def record_not_found
    respond_to do |format|
      format.json { render json: { message: "Record Not Found" }, status: :not_found }
    end
  end
end
