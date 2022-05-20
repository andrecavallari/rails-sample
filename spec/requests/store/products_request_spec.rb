# frozen_string_literal: true

RSpec.describe 'Store Products Requests', type: :request do
  let(:user) { create(:user) }
  let(:json_response) { JSON.parse(response.body, symbolize_names: true) }

  describe 'GET /store/products' do
    let!(:products) { create_list(:store_product, 2) }

    before { get store_products_path, headers: auth_header(user) }

    it 'responds with Ok', :aggregate_failures do
      expect(response).to have_http_status(:ok)
      expect(products[0]).to have_attributes(
        name: json_response[0][:name],
        price: json_response[0][:price],
        final_price: json_response[0][:final_price],
        segment_id: json_response[0][:segment_id]
      )
      expect(products[1]).to have_attributes(
        name: json_response[1][:name],
        price: json_response[1][:price],
        final_price: json_response[1][:final_price],
        segment_id: json_response[1][:segment_id]
      )
    end
  end

  describe 'POST /store/products' do
    subject(:do_request) do
      post store_products_path, params: {
        product: {
          name: product_name,
          price: product_price,
          segment_id: segment_id
        }
      }, headers: auth_header(user)
    end

    let(:product_name) { 'Mouse' }
    let(:product_price) { 100 }
    let(:segment_id) { segment.id }
    let!(:segment) { create(:store_segment, name: 'Importado', operation: 'price + (price * 0.15)') }

    context 'when params are ok' do
      it 'creates a new product', :aggregate_failures do
        expect { do_request }.to change(Store::Product, :count).by(1)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when name is missing' do
      let(:product_name) { nil }

      it 'responds with unprocessable_entity', :aggregate_failures do
        expect { do_request }.not_to change(Store::Product, :count)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response[:name]).to include('não pode ficar em branco')
      end
    end

    context 'when price is missing' do
      let(:product_price) { nil }

      it 'responds with unprocessable_entity', :aggregate_failures do
        expect { do_request }.not_to change(Store::Product, :count)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response[:price]).to include('não pode ficar em branco')
      end
    end

    context 'when segment is missing' do
      let(:segment_id) { nil }

      it 'responds with unprocessable_entity', :aggregate_failures do
        expect { do_request }.not_to change(Store::Product, :count)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response[:segment]).to include('é obrigatório')
      end
    end

    context 'when segment doesnt exists' do
      let(:segment_id) { 0 }

      it 'responds with unprocessable_entity', :aggregate_failures do
        expect { do_request }.not_to change(Store::Product, :count)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response[:segment]).to include('é obrigatório')
      end
    end
  end

  describe 'PATCH /store/products/:id' do
    subject(:do_request) do
      patch store_product_path(product_id), params: { product: product_params }, headers: auth_header(user)
    end

    let(:product_id) { product.id }
    let(:segment) { create(:store_segment, name: 'Imported', operation: 'price + (price * 0.1)') }
    let!(:product) { create(:store_product, name: 'Mouse', price: 100.0, segment: segment) }

    context 'when update name and price' do
      let(:product_params) { { name: 'Gamer Mouse', price: 200.0 } }

      it 'updates product', :aggregate_failures do
        expect { do_request and product.reload }
          .to change(product, :name).from('Mouse').to('Gamer Mouse')
          .and change(product, :price).from(100.0).to(200.0)
          .and change(product, :final_price).from(110.0).to(220.0)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when update segment' do
      let(:new_segment) { create(:store_segment, name: 'Luxury imported', operation: 'price + (price * 0.3)') }
      let(:product_params) { { segment_id: new_segment.id } }

      it 'updates product', :aggregate_failures do
        expect { do_request and product.reload }
          .to change(product, :segment).from(segment).to(new_segment)
          .and change(product, :final_price).from(110.0).to(130.0)
          .and not_change(product, :name)
          .and not_change(product, :price)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when product doesnt exists' do
      let(:product_params) { { name: 'Some new name' } }
      let(:product_id) { 0 }

      before { do_request }

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'DELETE /store/products/:id' do
    subject(:do_request) { delete store_product_path(product_id), headers: auth_header(user) }

    let!(:product) { create(:store_product) }
    let(:product_id) { product.id }

    context 'when product exists' do
      it 'deletes product', :aggregate_failures do
        expect { do_request }.to change(Store::Product, :count).by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when product doesnt exists' do
      let(:product_id) { 0 }

      it 'responds with not_found', :aggregate_failures do
        expect { do_request }.not_to change(Store::Product, :count)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
