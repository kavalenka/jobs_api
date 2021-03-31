# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JobsController do
  describe 'POST create' do
    let(:title) { 'Job Title' }
    let(:rate_per_hour) { 500 }
    let(:languages) { 'German,English' }

    it 'creates job' do
      post :create, params: { title: title, rate_per_hour: rate_per_hour, languages: languages }

      response_body = JSON.parse(response.body)

      expect(response_body['title']).to eq(title)
      expect(response_body['rate_per_hour']).to eq(rate_per_hour)
      expect(response_body['languages']).to eq(languages.split(','))
    end
  end
end
