# frozen_string_literal: true

RSpec.describe 'Auth Requests', type: :request do
  include Helpers

  let(:json_response) { JSON.parse(response.body, symbolize_names: true) }
  let(:user) { create(:user, email: 'lorem@ipsum.com', password: 'loremipsum') }

  describe 'POST /auth/login' do
    subject(:do_request) { post '/auth/login', params: { email: email, password: password } }

    let(:email) { user.email }
    let(:password) { 'loremipsum' }

    before { do_request }

    context 'with valid params' do
      it 'returns ok', :aggregate_failures do
        expect(response).to have_http_status(:ok)
        expect(json_response[:token]).to be_present
      end
    end

    context 'with wrong email' do
      let(:email) { 'another@exmaple.com' }

      it 'returns unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with wrong password' do
      let(:password) { 'notloremipsum' }

      it 'returns unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /auth/logout' do
    context 'with auth header' do
      before { delete '/auth/logout', headers: auth_header(user) }

      it 'returns ok', :aggregate_failures do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'without auth header' do
      before { delete '/auth/logout' }

      it 'returns unprocessable entity' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
