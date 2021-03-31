# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authorize!, only: :apply

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

  def apply
    job = Job.find_by(id: params[:job_id])

    render_not_found(Job) and return unless job

    render json: { message: 'You can\'t apply for one job twice.' } and return if job.in? current_user.jobs

    current_user.jobs << job

    render json: { message: 'You\'ve successfully applied for a job.' }
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
