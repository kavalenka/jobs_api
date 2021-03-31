# frozen_string_literal: true

FactoryBot.define do
  factory :job do
    title { 'Gold Digger' }
    rate_per_hour { 999 }
    languages { %w[English German] }

    trait :with_shift do
      after(:create) do |job|
        create(:shift, job: job)
      end
    end
  end
end
