# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShiftsController do
  describe 'POST create' do
    subject do
      post :create, params: { start_date: start_date, working_hours: working_hours, job_id: job.id }
    end

    let(:job) { create(:job) }
    let(:start_date) { Date.tomorrow }
    let(:working_hours) { 6 }

    it 'creates shift' do
      expect { subject }.to change(Shift, :count).by(1)
    end
  end
end
