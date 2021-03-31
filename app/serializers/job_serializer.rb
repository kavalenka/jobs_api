# frozen_string_literal: true

class JobSerializer < ActiveModel::Serializer
  attributes :id, :title, :total_salary, :languages

  def total_salary
    object.shifts.sum(:working_hours) * object.rate_per_hour
  end
end
