# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController do
  describe 'POST create' do
    let(:email) { 'test@mail.com' }

    it 'creates user' do
      post :create, params: { email: email, password: '1' }

      response_body = JSON.parse(response.body)

      expect(response_body['email']).to eq(email)
    end
  end

  describe 'POST login' do
    let(:email) { 'test@mail.com' }
    let(:password) { '1' }
    before { create(:user, email: email, password: password, password_confirmation: password) }

    it 'logs in user' do
      post :login, params: { email: email, password: password }

      response_body = JSON.parse(response.body)

      expect(response_body['token']).to be_present
    end
  end

  describe 'POST apply' do
    let(:email) { 'test@mail.com' }
    let(:password) { '1' }
    let!(:user) do
      create(:user, email: email, password: password, password_confirmation: password)
    end
    let!(:job) { create(:job, :with_shift) }
    let(:token) do
      JWT.encode({ user_id: user.id }, ENV['JWT_SECRET'])
    end
    let(:headers) { { 'Authorization' => "Bearer #{token}" } }

    context 'when unauthorized' do
      it 'returns error message' do
        post :apply, params: { job_id: job.id }

        response_body = JSON.parse(response.body)

        expect(response_body).to eq({ 'message' => 'Unauthorized' })
      end
    end

    context 'when first application' do
      it 'applies user for a job' do
        request.headers.merge! headers
        post :apply, params: { job_id: job.id }

        response_body = JSON.parse(response.body)

        expect(response_body).to eq({ 'message' => "You've successfully applied for a job." })
      end
    end

    context 'when already applied' do
      before do
        user.jobs << job
      end

      it 'returns error message' do
        request.headers.merge! headers
        post :apply, params: { job_id: job.id }

        response_body = JSON.parse(response.body)

        expect(response_body).to eq({ 'message' => "You can't apply for one job twice." })
      end
    end
  end
end
