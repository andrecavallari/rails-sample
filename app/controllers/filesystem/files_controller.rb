# frozen_string_literal: true

module Filesystem
  class FilesController < ApplicationController
    before_action :set_file, only: %i[update destroy]

    def create
      @file = File.new(create_file_params)

      render json: @file, status: :created and return if @file.save

      render json: @file.errors, status: :unprocessable_entity
    end

    def update
      render json: @file and return if @file.update(update_file_params)

      render json: @file.errors, status: :unprocessable_entity
    end

    def destroy
      head :no_content and return if @file.destroy

      render json: @file.errors, status: :unprocessable_entity
    end

    private

    def set_file
      @file = File.find(params[:id])
    end

    def create_file_params
      params.require(:file).permit(:content, :parent_id)
    end

    def update_file_params
      params.require(:file).permit(:parent_id)
    end
  end
end
