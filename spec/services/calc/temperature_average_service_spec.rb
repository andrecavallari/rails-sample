# frozen_string_literal: true

RSpec.describe Calc::TemperatureAverageService, type: :service do
  subject(:action) { described_class.new(forecast_data).call }

  describe '#call' do
    let(:forecast_data) { JSON.parse file_fixture('open_weather/forecast_response.json').read }
    let(:expected_data) do
      [
        { date: '2021-08-17', temp_avg: 21.33 },
        { date: '2021-08-18', temp_avg: 23.14 },
        { date: '2021-08-16', temp_avg: 20.21 },
        { date: '2021-08-19', temp_avg: 23.92 },
        { date: '2021-08-20', temp_avg: 24.34 }
      ]
    end

    it { is_expected.to match_array(expected_data) }
  end
end
