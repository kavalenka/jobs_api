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
end
