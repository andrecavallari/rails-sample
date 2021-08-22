# frozen_string_literal: true

class TweetWeatherController < ApplicationController
  def create
    TweetWeatherJob.perform_later(params[:city], params[:state], params[:country])

    head :no_content
  end
end
