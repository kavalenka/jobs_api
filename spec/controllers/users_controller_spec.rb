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
end
