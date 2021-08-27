# frozen_string_literal: true

RSpec.describe 'Auth Requests', type: :request do
  include Helpers

  let(:json_response) { JSON.parse(response.body, symbolize_names: true) }
  let(:user) { create(:user, email: 'lorem@ipsum.com', password: 'loremipsum') }

  before { JWT::DB.clear }

  after { JWT::DB.clear }

  describe 'GET /auth/sessions' do
    let(:user) { create(:user) }

    before do
      2.times { JWT::DB.create(user.id, { user_agent: 'Mozilla' }) }
      get '/auth/sessions', headers: auth_header(user)
    end

    it 'returns a 200 status code', :aggregate_failures do
      expect(response).to have_http_status(:ok)
      expect(json_response.size).to eq(3)
    end
  end

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

  describe 'DELETE /auth/revoke' do
    subject(:do_request) { delete auth_path(jti), headers: headers }

    let!(:headers) { auth_header(user) }
    let!(:jti) { JWT::DB.create(user.id, { user_agent: 'Webkit' }) }

    context 'when key exists' do
      it 'excludes a key', :aggregate_failures do
        expect { do_request }.to change { JWT::DB.user_keys(user.id).size }.by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when key doesnt exists' do
      let(:jti) { SecureRandom.hex(10) }

      before { do_request }

      it 'returns not found', :aggregate_failures do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
