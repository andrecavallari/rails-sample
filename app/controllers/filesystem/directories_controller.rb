# frozen_string_literal: true

module Filesystem
  class DirectoriesController < ApplicationController
    include JSONAPI::Deserialization
    include JSONAPI::Fetching

    before_action :set_directory, only: %i[show update destroy]

    def index
      render jsonapi: Directory.where(parent_id: nil)
    end

    def show
      render jsonapi: @directory
    end

    def create
      directory = Directory.new(directory_params)

      if directory.save
        render jsonapi: directory, status: :created
      else
        render jsonapi_errors: directory.errors, status: :unprocessable_entity
      end
    end

    def update
      if @directory.update(directory_params)
        render jsonapi: @directory
      else
        render jsonapi_errors: @directory.errors, status: :unprocessable_entity
      end
    end

    def destroy
      if @directory.destroy
        head :no_content
      else
        render jsonapi_errors: @directory.errors
      end
    end

    private

    def directory_params
      jsonapi_deserialize(params, only: %i[name parent_id])
    end

    def set_directory
      @directory = Directory.find(params[:id])
    end

    def jsonapi_meta(resources)
      { count: resources.count } if resources.respond_to?(:count)
    end
  end
end
