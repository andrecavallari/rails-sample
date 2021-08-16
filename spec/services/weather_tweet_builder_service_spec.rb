# frozen_string_literal: true

RSpec.describe WeatherTweetBuilderService, type: :service do
  describe '#call' do
    subject(:action) { described_class.new(current_weather, parsed_forecast_data).call }

    let(:current_weather) { JSON.parse file_fixture('open_weather/weather_response.json').read }
    let(:forecast_data) { JSON.parse file_fixture('open_weather/forecast_response.json').read }
    let(:parsed_forecast_data) { Calc::TemperatureAverageService.new(forecast_data).call }
    let(:expected_message) do
      'Em Cascavel: nuvens dispersas, 23.78°C. Média para os próximos dias: 20.21°C em 16/08, 21.33°C em 17/08, ' \
        '23.14°C em 18/08, 23.92°C em 19/08 e 24.34°C em 20/08'
    end

    it { is_expected.to eq expected_message }
  end
end
