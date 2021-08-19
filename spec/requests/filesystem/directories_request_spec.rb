# frozen_string_literal: true

RSpec.describe 'Directories requests', type: :request do
  describe 'GET /filesystem/directories' do
    let!(:directories) { create_list(:filesystem_directory, 2) }
    let(:json_response) { JSON.parse(response.body, symbolize_names: true) }

    before { get filesystem_directories_path }

    it 'lists directories', :aggregate_failures do
      expect(json_response[:data][0][:attributes][:id]).to eq(directories[0].id)
      expect(json_response[:data][0][:attributes][:name]).to eq(directories[0].name)
      expect(json_response[:data][1][:attributes][:id]).to eq(directories[1].id)
      expect(json_response[:data][1][:attributes][:name]).to eq(directories[1].name)
    end
  end

  describe 'GET /filesystem/directories/:id' do
    let(:directory) { create(:filesystem_directory) }
    let(:json_response) { JSON.parse(response.body, symbolize_names: true) }

    before { get filesystem_directory_path(directory_id) }

    context 'when directory exists' do
      let(:directory_id) { directory.id }

      it 'returns the directory', :aggregate_failures do
        expect(response).to have_http_status(:ok)
        expect(json_response[:data][:id].to_i).to eq(directory.id)
      end
    end

    context 'when directory doesnt exists' do
      let(:directory_id) { 0 }

      it 'returns not found' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /filesystem/directories' do
    subject(:do_request) do
      post filesystem_directories_path, params: {
        data: {
          attributes: {
            name: directory_name,
            parent_id: parent_directory_id
          }
        }
      }
    end

    let!(:parent) { create(:filesystem_directory) }
    let(:json_response) { JSON.parse(response.body, symbolize_names: true) }

    context 'when have directory name and parent directory id' do
      let(:directory_name) { 'Dir one' }
      let(:parent_directory_id) { parent.id }

      it 'creates directory', :aggregate_failures do
        expect { do_request }.to change(Filesystem::Directory, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(json_response[:data][:attributes][:name]).to eq(directory_name)
        expect(json_response[:data][:relationships][:parent][:data][:id]).to eq(parent_directory_id.to_s)
      end
    end

    context 'when have directory name and parent_id is nil' do
      let(:directory_name) { 'Dir one' }
      let(:parent_directory_id) { nil }

      it 'creates directory in root', :aggregate_failures do
        expect { do_request }.to change(Filesystem::Directory, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(json_response[:data][:attributes][:name]).to eq(directory_name)
        expect(json_response[:data][:relationships][:parent][:data]).to be_nil
      end
    end

    context 'when directory name is nil' do
      let(:directory_name) { nil }
      let(:parent_directory_id) { nil }

      it 'creates directory in root', :aggregate_failures do
        expect { do_request }.not_to change(Filesystem::Directory, :count)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response[:errors][0][:status]).to eq('422')
        expect(json_response[:errors][0][:title]).to eq('Unprocessable Entity')
        expect(json_response[:errors][0][:detail]).to eq('Nome está em branco')
        expect(json_response[:errors][0][:code]).to eq('blank')
      end
    end
  end

  describe 'PATCH /filesystem/directories/:id' do
    subject(:do_action) do
      patch filesystem_directory_path(directory_id), params: {
        data: {
          attributes: {
            name: new_name,
            parent_id: new_parent_id
          }
        }
      }
    end

    let(:parent) { create(:filesystem_directory, name: 'Root') }
    let(:directory) { create(:filesystem_directory, name: 'Root_1') }
    let(:directory_id) { directory.id }

    context 'when name is present and parent_id is present' do
      let(:new_name) { 'Dir one' }
      let(:new_parent_id) { parent.id }

      it 'updates directory', :aggregate_failures do
        expect { do_action and directory.reload }.to change(directory, :name)
          .from('Root_1').to('Dir one')
          .and change(directory, :parent_id).from(nil).to(parent.id)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when name is present but parent_id is nil' do
      let(:new_name) { 'Dir one' }
      let(:new_parent_id) { nil }

      it 'updates directory', :aggregate_failures do
        expect { do_action and directory.reload }.to change(directory, :name)
          .from('Root_1').to('Dir one')
          .and not_change(directory, :parent_id).from(nil)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when name is blank' do
      let(:new_name) { nil }
      let(:new_parent_id) { nil }

      it 'responds with error', :aggregate_failures do
        expect { do_action and directory.reload }.to not_change(directory, :name).and not_change(directory, :parent_id)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE/filesystem/directories/:id' do
    subject(:do_request) { delete filesystem_directory_path(directory_id) }

    let!(:directory) { create(:filesystem_directory) }

    context 'when directory exists' do
      let(:directory_id) { directory.id }

      it 'deletes directory', :aggregate_failures do
        expect { do_request }.to change(Filesystem::Directory, :count).by(-1)
        expect(response).to have_http_status(:no_content)
        expect { directory.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when directory doesnt exists' do
      let(:directory_id) { 0 }

      it 'returns not found', :aggregate_failures do
        expect { do_request }.not_to change(Filesystem::Directory, :count)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
