# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Endpoint /users' do
  describe 'POST /users' do
    subject { post('/users', params: params) and response }

    let(:params) { { email: email, password: password } }

    context 'with valid params' do
      let(:email) { 'test@mail.com' }
      let(:password) { '1' }

      context 'new user' do
        it 'creates a new user' do
          expect(subject.status).to eq 200
          expect(JSON.parse(subject.body)['email']).to eq(email)
        end
      end

      context 'existing user' do
        let!(:user) { create(:user, email: email) }
        let(:response_body) do
          '{"error":"Unprocessable entity","error_messages":{"email":["has already been taken"]}}'
        end

        it 'returns 422 error' do
          expect(subject.status).to eq 422
          expect(subject.body).to eq response_body
        end
      end
    end

    context 'with invalid params' do
      let(:email) { 'fdsf' }
      let(:password) { '1' }
      let(:response_body) do
        '{"error":"Unprocessable entity","error_messages":{"email":["is invalid"]}}'
      end

      it 'returns unauthorized response' do
        expect(subject.status).to eq 422
        expect(subject.body).to eq response_body
      end
    end
  end

  describe 'POST /users/login' do
    subject { post('/users/login', params: params) and response }

    let(:email) { 'test@mail.com' }
    let(:password) { '1' }
    before { create(:user, email: email, password: password, password_confirmation: password) }

    context 'with valid password' do
      let(:params) { { email: email, password: password } }

      it 'logs in user' do
        expect(subject.status).to eq 200
        expect(JSON.parse(subject.body)['token']).to be_present
      end
    end

    context 'with invalid password' do
      let(:params) { { email: email, password: 'password' } }

      it 'return 401 response' do
        expect(subject.status).to eq 401
        expect(subject.body).to eq '{"message":"Unauthorized"}'
      end
    end
  end
end
