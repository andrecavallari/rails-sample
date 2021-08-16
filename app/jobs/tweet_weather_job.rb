# frozen_string_literal: true

class TweetWeatherJob < ApplicationJob
  def perform(city_name, state_name, country = 'BR')
    current_weather = OpenWeatherApi.current_weather(city_name, state_name, country)
    forecast_data = OpenWeatherApi.forecast(city_name, state_name, country)
    avg_forecast_data = Calc::TemperatureAverageService.new(forecast_data).call
    message = WeatherTweetBuilderService.new(current_weather, avg_forecast_data).call
    TwitterClient.tweet(message)
  end
end
