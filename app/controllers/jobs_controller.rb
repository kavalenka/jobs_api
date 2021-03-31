# frozen_string_literal: true

class JobsController < ApplicationController
  def create
    job = Job.new(initialize_params)

    if job.save
      render json: job, serializer: JobSerializer
    else
      render_unprocessable_entity(job)
    end
  end

  private

  def initialize_params
    job_params.tap do |params|
      params[:languages] = job_params[:languages]&.split(',')&.map(&:strip)
    end
  end

  def job_params
    params.permit(:title, :rate_per_hour, :languages).to_h
  end
end
