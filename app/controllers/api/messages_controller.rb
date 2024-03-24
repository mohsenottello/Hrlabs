# frozen_string_literal: true

# controller for creating and index user
class Api::MessagesController < Api::ApplicationController
  attr_reader :current_user, :current_message

  before_action :authenticate
  before_action :set_user
  before_action :set_message, only: %i[update show]

  # Get /api/messages
  def index
    messages = current_user.messages
    messages = messages.search_by_keyword(params[:keyword]) if params[:keyword]

    render json: messages.limit(@limit).offset(@offset * @limit), meta: { per_page: @limit, page: @offset }
  end

  # Get /api/messages/:id
  def show
    render json: current_message
  end

  # Post /api/messages
  def create
    # it can be handle by current_user.messages.create!(message_params) but it is faster
    return render_error(message: 'parameter title is required.') if message_params[:title].blank?

    render json: current_user.messages.create!(message_params)
  end

  # Patch /api/messages/:id
  def update
    current_message.update!(message_params)

    render json: current_message
  end

  private

  def set_message
    render_error(message: 'parameter id is required.') if params[:id].blank?
    @current_message = current_user.messages.where(id: params[:id]).first

    render_error(status_code: :not_found, message: 'message cannot find') unless current_message
  end

  def authenticate
    decode_token
  rescue JWT::DecodeError
    unauthorized_error
  end

  def set_user
    @current_user = User.find_by!(email: decode_token[0]['email'])
  rescue ActiveRecord::RecordNotFound
    unauthorized_error
  end

  def decode_token
    @decode_token ||= JWT.decode request.headers['Authorization'], Rails.application.credentials.dig(:user, :token), 'HS256'
  end

  def unauthorized_error
    render_error(status_code: :unauthorized, message: 'invalid token')
  end

  def message_params
    params.permit(:title, :body)
  end
end
