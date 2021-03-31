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
      expect(response_body['languages']).to eq(languages.split(','))
    end
  end

  describe 'GET search' do
    before do
      create(:job, :with_shift, title: 'Programmer', languages: 'English, German')
      create(:job, :with_shift, title: 'Welder', languages: 'Spanish, German')
      create(:job, :with_shift, title: 'Photographer', languages: 'Chinese')
    end

    context 'with valid params' do
      context 'search by title' do
        it 'searches for a job' do
          get :search, params: { field: 'title', value: 'og' }

          response_body = JSON.parse(response.body)

          expect(response_body.size).to eq(2)
        end
      end

      context 'search by language' do
        it 'searches for a job' do
          get :search, params: { field: 'language', value: 'ne' }

          response_body = JSON.parse(response.body)

          expect(response_body.size).to eq(1)
        end
      end
    end

    context 'with invalid params' do
      it 'returns bad request error' do
        get :search, params: { field: 'titles' }

        response_body = JSON.parse(response.body)

        expect(response_body).to eq({ 'message' => 'Bad request' })
      end
    end
  end
end
