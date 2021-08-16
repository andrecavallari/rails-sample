# frozen_string_literal: true

class WeatherTweetBuilderService
  def initialize(current_weather, forecast_data)
    @current_weather = current_weather
    @forecast_data = forecast_data
  end

  def call
    I18n.t('weather_tweet.message', city: city, condition: condition, temp: temp, forecast: forecast)
  end

  private

  def city
    @city ||= @current_weather['name']
  end

  def condition
    @condition ||= @current_weather['weather'][0]['description']
  end

  def temp
    @temp ||= @current_weather['main']['temp']
  end

  def forecast
    @forecast_data.map do |forecast_item|
      date = I18n.l Date.parse(forecast_item[:date]), format: :short
      temp = "#{forecast_item[:temp_avg]}°C"
      [temp, date].join(I18n.t('junctions.in'))
    end.to_sentence
  end
end
