# frozen_string_literal: true

RSpec.describe 'Directories requests', type: :request do
  let(:user) { create(:user) }
  let(:json_response) { JSON.parse(response.body, symbolize_names: true) }

  describe 'POST /filesystem/files' do
    subject(:do_request) do
      post filesystem_files_path, params: {
        file: {
          content: content,
          parent_id: directory.id
        }
      }, headers: auth_header(user)
    end

    let(:directory) { create(:filesystem_directory) }

    context 'when file is present' do
      let(:content) { fixture_file_upload('Document.pdf') }

      it 'creates a file', :aggregate_failures do
        expect { do_request }.to change(Filesystem::File, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(json_response[:id]).to be_present
        expect(json_response[:name]).to eq('Document.pdf')
        expect(json_response[:parent_id]).to eq(directory.id)
      end
    end

    context 'when empty file' do
      let(:content) { nil }

      it 'fails on validation', :aggregate_failures do
        expect { do_request }.not_to change(Filesystem::File, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /filesystem/files/:id' do
    subject(:do_request) do
      patch filesystem_file_path(file_id), params: {
        file: {
          parent_id: parent_id
        }
      }, headers: auth_header(user)
    end

    let!(:file) { create(:filesystem_file) }
    let!(:parent) { create(:filesystem_directory) }

    context 'when file and parent exists' do
      let(:file_id) { file.id }
      let(:parent_id) { parent.id }

      it 'updates a file', :aggregate_failures do
        expect { do_request and file.reload }.to change(file, :parent_id).from(nil).to(parent.id)
        expect(json_response[:id]).to eq(file.id)
        expect(json_response[:name]).to eq(file.name)
        expect(json_response[:parent_id]).to eq(parent.id)
      end
    end

    context 'when file doesnt exists' do
      let(:file_id) { 0 }
      let(:parent_id) { parent.id }

      it 'returns not found', :aggregate_failures do
        expect { do_request and file.reload }.not_to change(file, :parent_id)
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when file exists but parent doesnt' do
      let(:file_id) { file.id }
      let(:parent_id) { 0 }

      it 'returns not found', :aggregate_failures do
        expect { do_request and file.reload }.not_to change(file, :parent_id)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response[:directory]).to include('diretório pai não existe')
      end
    end
  end

  describe 'DELETE/filesystem/files/:id' do
    subject(:do_request) { delete filesystem_file_path(file_id), headers: auth_header(user) }

    context 'when file exists' do
      let!(:file) { create(:filesystem_file) }
      let(:file_id) { file.id }

      it 'deletes a file', :aggregate_failures do
        expect { do_request }.to change(Filesystem::File, :count).by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when file doesnt exists' do
      let(:file_id) { 0 }

      it 'returns not found', :aggregate_failures do
        expect { do_request }.not_to change(Filesystem::File, :count)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
