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

  private

  def user_params
    params.permit(:email, :password)
  end
end
