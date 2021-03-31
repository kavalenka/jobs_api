# frozen_string_literal: true

class Shift < ApplicationRecord
  MAX_JOB_SHIFTS = 7

  belongs_to :job

  validates_presence_of :start_date, :working_hours
  validate :shifts_count_within_bounds, on: :create
  validate :start_date_in_future
  validates_numericality_of :working_hours, greater_than: 0

  private

  def shifts_count_within_bounds
    errors.add(:base, "too many shifts for job #{job_id}") if job.shifts.size >= MAX_JOB_SHIFTS
  end

  def start_date_in_future
    errors.add(:start_date, 'must be in the future') if start_date && start_date <= Date.today
  end
end
