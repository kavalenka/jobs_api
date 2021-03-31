# frozen_string_literal: true

class ShiftsController < ApplicationController
  def create
    job = Job.find_by(id: shift_params[:job_id])

    render_not_found(Job) and return unless job

    shift = job.shifts.new(shift_params.except(:job_id))

    if shift.save
      render json: shift.job, serializer: JobSerializer
    else
      render_unprocessable_entity(shift)
    end
  end

  private

  def shift_params
    params.permit(:start_date, :working_hours, :job_id)
  end
end
