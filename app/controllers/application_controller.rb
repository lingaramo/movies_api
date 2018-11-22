class ApplicationController < ActionController::API
  include ApiErrorResponder

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found(exception)
    render json: { error: exception.message }, status: 404
  end
end
