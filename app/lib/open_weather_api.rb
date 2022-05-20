# frozen_string_literal: true

class OpenWeatherApi
  include HTTParty
  base_uri 'api.openweathermap.org/data/2.5'
  DEFAULT_UNITS = 'metric'
  DEFAULT_LANGUAGE = 'pt_br'
  DEFAULT_COUNTRY = 'BR'

  class << self
    def current_weather(city, state = nil, country = DEFAULT_COUNTRY)
      query_string = [city, state, country].compact.join(',')
      get('/weather', query: { q: query_string })
    end

    def forecast(city, state = nil, country = DEFAULT_COUNTRY)
      query_string = [city, state, country].compact.join(',')
      get('/forecast', query: { q: query_string })
    end

    private

    def get(path, query: {})
      super(path, query: query.merge(
        appid: ENV.fetch('OPEN_WEATHER_API_KEY', nil),
        units: DEFAULT_UNITS,
        lang: DEFAULT_LANGUAGE
      ))
    end
  end
end
