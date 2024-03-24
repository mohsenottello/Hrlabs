# frozen_string_literal: true

# controller for creating and index user
class Api::UsersController < Api::ApplicationController
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
end
