# frozen_string_literal: true

RSpec.describe 'Directories requests', type: :request do
  describe 'GET /filesystem/directories' do
    let!(:directory) { create(:filesystem_directory) }
    let!(:file) { create(:filesystem_file) }
    let!(:file_in_directory) { create(:filesystem_file, directory: directory) }
    let(:json_response) { JSON.parse(response.body, symbolize_names: true) }

    before { get filesystem_directories_path }

    it 'lists directories', :aggregate_failures do
      expect(json_response[:directories][0][:id]).to eq(directory.id)
      expect(json_response[:directories][0][:name]).to eq(directory.name)
      expect(json_response[:directories][0][:parent_id]).to eq(directory.parent_id)
      expect(json_response[:files][0][:name]).to eq(file.name)
      expect(json_response[:files][0][:parent_id]).to eq(file.parent_id)
      expect(json_response[:files].pluck(:id)).not_to include(file_in_directory.id)
    end
  end

  describe 'GET /filesystem/directories/:id' do
    let(:directory) { create(:filesystem_directory) }
    let(:json_response) { JSON.parse(response.body, symbolize_names: true) }

    context 'when directory exists but doesnt have children' do
      let(:directory_id) { directory.id }

      before { get filesystem_directory_path(directory_id) }

      it 'returns the directory', :aggregate_failures do
        expect(response).to have_http_status(:ok)
        expect(json_response[:files]).to be_empty
        expect(json_response[:directories]).to be_empty
      end
    end

    context 'when directory exists and has children' do
      let(:directory_id) { directory.id }
      let!(:subdirectory) { create(:filesystem_directory, parent: directory) }
      let!(:file) { create(:filesystem_file, directory: directory) }

      before { get filesystem_directory_path(directory_id) }

      it 'returns directory with children', :aggregate_failures do
        expect(json_response[:directories][0][:id]).to eq(subdirectory.id)
        expect(json_response[:directories][0][:name]).to eq(subdirectory.name)
        expect(json_response[:directories][0][:parent_id]).to eq(directory.id)
        expect(json_response[:files][0][:name]).to eq(file.name)
        expect(json_response[:files][0][:parent_id]).to eq(directory.id)
      end
    end

    context 'when directory doesnt exists' do
      let(:directory_id) { 0 }

      before { get filesystem_directory_path(directory_id) }

      it 'returns not found' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /filesystem/directories' do
    subject(:do_request) do
      post filesystem_directories_path, params: {
        directory: {
          name: directory_name,
          parent_id: parent_directory_id
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
        expect(json_response[:name]).to eq(directory_name)
        expect(json_response[:parent_id]).to eq(parent_directory_id)
      end
    end

    context 'when have directory name and parent_id is nil' do
      let(:directory_name) { 'Dir one' }
      let(:parent_directory_id) { nil }

      it 'creates directory in root', :aggregate_failures do
        expect { do_request }.to change(Filesystem::Directory, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(json_response[:name]).to eq(directory_name)
        expect(json_response[:parent_id]).to be_nil
      end
    end

    context 'when directory name is nil' do
      let(:directory_name) { nil }
      let(:parent_directory_id) { nil }

      it 'creates directory in root', :aggregate_failures do
        expect { do_request }.not_to change(Filesystem::Directory, :count)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response[:name]).to eq(['está em branco'])
      end
    end
  end

  describe 'PATCH /filesystem/directories/:id' do
    subject(:do_action) do
      patch filesystem_directory_path(directory_id), params: {
        directory: {
          name: new_name,
          parent_id: new_parent_id
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
