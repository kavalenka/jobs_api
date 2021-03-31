# frozen_string_literal: true

class UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      render json: user, serializer: UserSerializer
    else
      render_unprocessable_entity(user)
    end
  end

  def login
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { token: token }
    else
      render_unauthorized
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
