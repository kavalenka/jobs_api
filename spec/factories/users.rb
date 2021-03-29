# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'email@mail.com' }
    password { 'MyString123' }
    password_confirmation { 'MyString123' }
  end
end
