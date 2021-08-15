# frozen_string_literal: true

RSpec.describe OpenWeatherApi, :vcr do
  describe '.current_weather' do
    subject(:action) { described_class.current_weather(city, 'PR', 'BR') }

    context 'with correct city name' do
      let(:city) { 'Cascavel' }
      let(:expected_json) { JSON.parse file_fixture('open_weather/weather_response.json').read }

      it 'retrieve city current weather data', :aggregate_failures do
        expect(JSON.parse(action.body)).to eq(expected_json)
        expect(action.code).to eq(200)
      end
    end

    context 'when wrong city name' do
      let(:city) { 'Asdf' }

      it 'returns error', :aggregate_failures do
        expect(action.body).to eq('{"cod":"404","message":"city not found"}')
        expect(action.code).to eq(404)
      end
    end
  end

  describe '.forecast' do
    subject(:action) { described_class.forecast(city, 'PR', 'BR') }

    context 'with correct city name' do
      let(:city) { 'Cascavel' }
      let(:expected_json) { JSON.parse file_fixture('open_weather/forecast_response.json').read }

      it 'retrieve city current weather data', :aggregate_failures do
        expect(JSON.parse(action.body)).to eq(expected_json)
        expect(action.code).to eq(200)
      end
    end

    context 'when wrong city name' do
      let(:city) { 'Asdf' }

      it 'returns error', :aggregate_failures do
        expect(action.body).to eq('{"cod":"404","message":"city not found"}')
        expect(action.code).to eq(404)
      end
    end
  end
end
