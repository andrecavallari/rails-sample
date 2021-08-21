# frozen_string_literal: true

module Store
  class SegmentsController < ApplicationController
    before_action :set_segment, only: %i[update destroy]

    def index
      render json: Segment.all
    end

    def create
      @segment = Segment.new(segment_params)

      render json: @segment, status: :created and return if @segment.save

      render json: @segment.errors, status: :unprocessable_entity
    end

    def update
      render json: @segment and return if @segment.update(segment_params)

      render json: @segment.errors, status: :unprocessable_entity
    end

    def destroy
      head :no_content and return if @segment.destroy
    end

    private

    def segment_params
      params.require(:segment).permit(:name, :operation)
    end

    def set_segment
      @segment = Segment.find(params[:id])
    end
  end
end
