# frozen_string_literal: true

class JobsController < ApplicationController
  SEARCH_FIELDS = %w[title languages].freeze

  def create
    job = Job.new(initialize_params)

    if job.save
      render json: job, serializer: JobSerializer
    else
      render_unprocessable_entity(job)
    end
  end

  def index
    jobs = if valid_search_params?
             Job.where("#{search_params[:field]} ~* ?", search_params[:value]).with_shifts
           else
             Job.with_shifts
           end

    render json: jobs
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

  def valid_search_params?
    search_params[:field].in?(SEARCH_FIELDS) && search_params[:value].present?
  end

  def search_params
    params.permit(:value, :field)
  end
end
