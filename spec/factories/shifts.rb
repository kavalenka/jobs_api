# frozen_string_literal: true

FactoryBot.define do
  factory :shift do
    job
    start_date { Date.tomorrow }
    working_hours { 8 }
  end
end
