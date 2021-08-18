# frozen_string_literal: true

module Filesystem
  class FilesController < ApplicationController
    include JSONAPI::Deserialization
    include JSONAPI::Fetching

    before_action :set_directory
    before_action :set_file, only: %i[update destroy]

    def index
      files = @directory.files
      render jsonapi: files
    end

    def create
      file = Filesystem::File.new(file_params)
      file.attachment.attach(file_data)

      if file.save
        render jsonapi: file
      else
        render jsonapi_errors: file.errors, status: :unprocessable_entity
      end
    end

    def update
      if @file.update(file_params)
        render jsonapi: @file
      else
        render jsonapi_errors: @file.errors
      end
    end

    def destroy
      @file.destroy
      head :no_content
    end

    private

    def set_directory
      @directory = Directory.find(params[:directory_id])
    end

    def set_file
      @file = File.find(params[:id])
    end

    def file_data
      params[:data][:attributes][:file]
    end

    def file_params
      params.require(:data).require(:attributes).permit(:directory_id).tap do |permitted|
        permitted[:directory_id] = @directory.id unless defined?(permitted[:directory_id])
      end
    end
  end
end
