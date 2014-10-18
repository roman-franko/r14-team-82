class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from ActionController::ParameterMissing, with: :param_missing
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def record_invalid(exception)
    render json: exception.message, status: :unprocessable_entity
  end

  def not_found(exception)
    render json: exception.message, status: :not_found
  end

  def param_missing(exception)
    render nothing: true, status: :bad_request
  end
end
