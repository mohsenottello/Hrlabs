# frozen_string_literal: true

# sharing methods with controller in API
class Api::ApplicationController < ActionController::API
  def set_format
    request.format = :json
  end

  def render_error(status_code: :unprocessable_entity, message: nil)
    render json: { errors: 'Can not procceed!', message: message }, status: status_code
  end
end
