# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Job, type: :model do
  subject { create(:job) }

  describe 'associations' do
    it { is_expected.to have_many(:shifts) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:rate_per_hour) }
    it { is_expected.to validate_presence_of(:languages) }
    it { is_expected.to validate_numericality_of(:rate_per_hour) }
  end
end
