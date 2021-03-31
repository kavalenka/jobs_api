# frozen_string_literal: true

class Job < ApplicationRecord
  has_many :shifts, dependent: :destroy
  has_many :user_jobs
  has_many :users, through: :user_jobs

  validates_presence_of :title, :languages, :rate_per_hour
  validates_numericality_of :rate_per_hour, greater_than: 0

  serialize :languages

  scope :with_shifts, -> { joins(:shifts).uniq }
end
