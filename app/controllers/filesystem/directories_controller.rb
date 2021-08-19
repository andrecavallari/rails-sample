# frozen_string_literal: true

module Filesystem
  class DirectoriesController < ApplicationController
    before_action :set_directory, only: %i[show update destroy]

    def index
      directories = Directory.where(parent_id: nil).order(:name)
      files = File.where(parent_id: nil).order(:name)

      render json: { directories: directories, files: files }
    end

    def show
      directories = Directory.where(parent_id: params[:id]).order(:name)
      files = File.where(parent_id: params[:id]).order(:name)

      render json: { directories: directories, files: files }
    end

    def create
      @directory = Directory.new(directory_params)

      render json: @directory, status: :created and return if @directory.save

      render json: @directory.errors, status: :unprocessable_entity
    end

    def update
      render json: @directory, status: :ok and return if @directory.update(directory_params)

      render json: @directory.errors, status: :unprocessable_entity
    end

    def destroy
      head :no_content and return if @directory.destroy

      render json: @directory.errors, status: :unprocessable_entity
    end

    private

    def directory_params
      params.require(:directory).permit(:name, :parent_id)
    end

    def set_directory
      @directory = Directory.find(params[:id])
    end
  end
end
