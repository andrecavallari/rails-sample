# frozen_string_literal: true

RSpec.describe 'Store Segments Requests', type: :request do
  let(:user) { create(:user) }
  let(:json_response) { JSON.parse(response.body, symbolize_names: true) }

  describe 'GET /store/segments' do
    let!(:segments) { create_list(:store_segment, 2) }

    before { get store_segments_path, headers: auth_header(user) }

    it 'returns status ok and segments', :aggregate_failures do
      expect(response).to have_http_status(:ok)
      expect(json_response.size).to eq(2)
      expect(segments[0]).to have_attributes(
        id: json_response[0][:id],
        name: json_response[0][:name],
        operation: json_response[0][:operation]
      )
      expect(segments[1]).to have_attributes(
        id: json_response[1][:id],
        name: json_response[1][:name],
        operation: json_response[1][:operation]
      )
    end
  end

  describe 'POST /store/segments' do
    subject(:do_request) do
      post store_segments_path, params: {
        segment: {
          name: segment_name,
          operation: segment_operation
        }
      }, headers: auth_header(user)
    end

    let(:segment_name) { 'Some segment name' }
    let(:segment_operation) { 'price + (price * 0.1)' }

    context 'when segment name and operation are filled' do
      it 'responds with ok', :aggregate_failures do
        expect { do_request }.to change(Store::Segment, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(json_response[:name]).to eq(segment_name)
        expect(json_response[:operation]).to eq(segment_operation)
      end
    end

    context 'when segment name is nil' do
      let(:segment_name) { nil }

      it 'responds with unprocessable entity', :aggregate_failures do
        expect { do_request }.not_to change(Store::Segment, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when segment operation is nil' do
      let(:segment_operation) { nil }

      it 'responds with unprocessable entity', :aggregate_failures do
        expect { do_request }.not_to change(Store::Segment, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /store/segments/:id' do
    subject(:do_request) do
      patch store_segment_path(segment_id), params: {
        segment: {
          name: segment_name,
          operation: segment_operation
        }
      }, headers: auth_header(user)
    end

    let!(:segment) { create(:store_segment, name: 'Imported', operation: 'price + (price * 0.2)') }
    let(:segment_id) { segment.id }
    let(:segment_name) { 'National' }
    let(:segment_operation) { 'price - (price * 0.1)' }

    context 'when name and segment are filled' do
      it 'responds with ok', :aggregate_failures do
        expect { do_request and segment.reload }
          .to change(segment, :name).from('Imported').to('National')
          .and change(segment, :operation).from('price + (price * 0.2)').to('price - (price * 0.1)')
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when name is nil' do
      let(:segment_name) { nil }

      it 'responds with unprocessable entity', :aggregate_failures do
        expect { do_request and segment.reload }.to not_change(segment, :name).and not_change(segment, :operation)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response[:name]).to include('não pode ficar em branco')
      end
    end

    context 'when operation is nil' do
      let(:segment_operation) { nil }

      it 'responds with unprocessable entity', :aggregate_failures do
        expect { do_request and segment.reload }.to not_change(segment, :name).and not_change(segment, :operation)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response[:operation]).to include('não pode ficar em branco')
      end
    end

    context 'when segment doesnt exists' do
      let(:segment_id) { 0 }

      before { do_request }

      it 'responds with not found', :aggregate_failures do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE /store/segments/:id' do
    subject(:do_request) { delete store_segment_path(segment_id), headers: auth_header(user) }

    let!(:segment) { create(:store_segment) }

    context 'when segment exists' do
      let(:segment_id) { segment.id }

      it 'deletes the segment', :aggregate_failures do
        expect { do_request }.to change(Store::Segment, :count).by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when segment doesnt exists' do
      let(:segment_id) { 0 }

      before { do_request }

      it { expect(response).to have_http_status(:not_found) }
    end
  end
end
