# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shift, type: :model do
  subject { create(:shift) }

  describe 'associations' do
    it { is_expected.to belong_to(:job) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:start_date) }
    it { is_expected.to validate_presence_of(:working_hours) }
    it { is_expected.to validate_numericality_of(:working_hours) }
  end
end
