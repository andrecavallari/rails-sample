# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    render json: { message: 'Welcome to the API' }
  end
end
