# frozen_string_literal: true

FactoryBot.define do
  factory :job do
    title { 'Gold Digger' }
    rate_per_hour { 999 }
    languages { %w[English German] }
  end
end
