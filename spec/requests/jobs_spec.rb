# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Endpoint /jobs' do
  describe 'POST /jobs' do
    subject { post('/jobs', params: params) and response }

    let(:params) { { title: title, rate_per_hour: rate_per_hour, languages: languages } }

    context 'with valid params' do
      let(:title) { 'Welder' }
      let(:rate_per_hour) { 700 }
      let(:languages) { 'English,German' }

      it 'creates a new job' do
        expect(subject.status).to eq 200
        expect(JSON.parse(subject.body)['title']).to eq(title)
        expect(JSON.parse(subject.body)['rate_per_hour']).to eq(rate_per_hour)
        expect(JSON.parse(subject.body)['languages']).to eq(languages.split(','))
      end
    end

    context 'with invalid params' do
      let(:title) { 'Welder' }
      let(:rate_per_hour) { 700 }
      let(:languages) { nil }
      let(:response_body) do
        '{"error":"Unprocessable entity","error_messages":{"languages":["can\'t be blank"]}}'
      end

      it 'returns unauthorized response' do
        expect(subject.status).to eq 422
        expect(subject.body).to eq response_body
      end
    end
  end
end
