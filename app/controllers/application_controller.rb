# frozen_string_literal: true

class ApplicationController < ActionController::API
  private

  def authorize!
    render_unauthorized unless current_user
  end

  def current_user
    @user = User.find_by(id: decoded_token[0]['user_id']) if decoded_token
  end

  def decoded_token
    return unless auth_header

    token = auth_header.split[1]

    begin
      JWT.decode(token, ENV['JWT_SECRET'], true, algorithm: 'HS256')
    rescue JWT::DecodeError
      nil
    end
  end

  def auth_header
    request.headers['Authorization']
  end

  def encode_token(payload)
    JWT.encode(payload, ENV['JWT_SECRET'])
  end

  def render_unauthorized
    render json: { message: 'Unauthorized' }, status: :unauthorized
  end

  def render_unprocessable_entity(entity)
    render json: { error: 'Unprocessable entity', error_messages: entity.errors }, status: :unprocessable_entity
  end

  def render_not_found(model)
    render json: { message: "#{model} not found" }, status: :not_found
  end
end
