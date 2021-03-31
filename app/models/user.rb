# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_jobs
  has_many :jobs, through: :user_jobs

  has_secure_password

  validates :email, presence: true, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/
  validates_uniqueness_of :email
end
