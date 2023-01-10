class ErrorsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:not_found, :unacceptable, :internal_server_error]

  def not_found
    authorize :error, :not_found?
    render status: 404
  end

  def unacceptable
    authorize :error, :unacceptable?
    render status: 422
  end

  def internal_server_error
    authorize :error, :internal_server_error?
    render status: 500
  end
end
