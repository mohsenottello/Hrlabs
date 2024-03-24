# frozen_string_literal: true

# sharing methods with controller in API
class Api::ApplicationController < ActionController::API
  DEFAULT_OFFSET = 0
  DEFAULT_LIMIT = 10
  MAX_LIMIT = 10

  before_action :set_format
  before_action :set_offset_and_limit, only: :index

  rescue_from ActiveRecord::RecordInvalid, with: :invalid

  def set_format
    request.format = :json
  end

  private

  def render_error(status_code: :unprocessable_entity, message: nil)
    render json: { errors: 'Can not procceed!', message: message }, status: status_code
  end

  def set_offset_and_limit
    @offset = (params[:page] || DEFAULT_OFFSET).to_i
    @limit = (params[:per_page] || DEFAULT_LIMIT).to_i
    @limit = 10 if @limit > MAX_LIMIT
  end

  def invalid(invalid_record)
    render_error(message: invalid_record.record.errors.full_messages)
  end
end
