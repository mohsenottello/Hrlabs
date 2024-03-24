# frozen_string_literal: true

# controller for creating and index user
class Api::UsersController < Api::ApplicationController
  DEFAULT_OFFSET = 0
  DEFAULT_LIMIT = 10
  MAX_LIMIT = 10

  before_action :set_offset_and_limit, only: :index

  rescue_from ActiveRecord::RecordInvalid, with: :invalid
  rescue_from ArgumentError, with: :invalid_email

  # Get /api/users
  def index
    render json: User.limit(@limit).offset(@offset * @limit), meta: { per_page: @limit, page: @offset }
  end

  # Post /api/users
  def create
    return render_error(message: 'parameter email is required.') if params[:email].blank?

    render json: Users::Create.call(params[:email])
  end

  private

  def invalid_email
    render_error(message: 'parameter email is invalid.') if params[:email].blank?
  end

  def invalid(invalid_record)
    render_error(message: invalid_record.record.errors.full_messages)
  end

  def set_offset_and_limit
    @offset = (params[:page] || DEFAULT_OFFSET).to_i
    @limit = (params[:per_page] || DEFAULT_LIMIT).to_i
    @limit = 10 if @limit > MAX_LIMIT
  end
end
