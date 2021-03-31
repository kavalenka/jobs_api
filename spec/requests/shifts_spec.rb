# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Endpoint /shifts' do
  describe 'POST /shifts' do
    subject { post('/shifts', params: params) and response }

    let(:params) { { start_date: start_date, working_hours: working_hours, job_id: job.id } }

    context 'with valid params' do
      let(:job) { create(:job) }
      let(:start_date) { Date.tomorrow }
      let(:working_hours) { 6 }

      it 'creates a new shift' do
        expect(subject.status).to eq 200
        expect(JSON.parse(subject.body)['title']).to eq(job.title)
        expect(JSON.parse(subject.body)['languages']).to eq(job.languages)
      end
    end

    context 'with invalid params' do
      let(:job) { create(:job) }
      let(:start_date) { Date.tomorrow }
      let(:working_hours) { nil }
      let(:response_body) do
        '{"error":"Unprocessable entity","error_messages":{"working_hours":["can\'t be blank","is not a number"]}}'
      end

      it 'returns 422 response' do
        expect(subject.status).to eq 422
        expect(subject.body).to eq response_body
      end
    end
  end
end
