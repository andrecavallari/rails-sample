# frozen_string_literal: true

module Store
  class ProductsController < ApplicationController
    before_action :set_product, only: %i[update destroy]

    def index
      render json: Product.all
    end

    def create
      @product = Product.new(product_params)

      render json: @product and return if @product.save

      render json: @product.errors, status: :unprocessable_entity
    end

    def update
      render json: @product and return if @product.update(product_params)

      render json: @product.errors, status: :unprocessable_entity
    end

    def destroy
      head :no_content if @product.destroy
    end

    private

    def product_params
      params.require(:product).permit(:name, :price, :segment_id)
    end

    def set_product
      @product = Product.find(params[:id])
    end
  end
end
