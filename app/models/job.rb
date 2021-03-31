# frozen_string_literal: true

class Job < ApplicationRecord
  # has_many :shifts
  # validate_on_create :shifts_count_within_bounds

  validates_presence_of :title, :languages, :rate_per_hour
  validates_numericality_of :rate_per_hour, greater_than: 0

  serialize :languages

  # def shifts_count_within_bounds
  #   return if shifts.blank?
  #
  #   errors.add('Too many shifts') if shifts.size >= 7
  # end
end
