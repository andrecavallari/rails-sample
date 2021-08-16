# frozen_string_literal: true

module Calc
  class TemperatureAverageService
    def initialize(forecast_data)
      @forecast_data = forecast_data
    end

    def call
      temp_list_grouped_by_date.map do |date, temp_list|
        {
          date: date,
          temp_avg: (temp_list.pluck(:temp).inject(:+).to_f / temp_list.size).round(2)
        }
      end
    end

    private

    def temp_list_grouped_by_date
      @temp_list_grouped_by_date ||= temp_list_with_date.group_by do |temp|
        temp[:date]
      end
    end

    def temp_list_with_date
      @temp_list_with_date ||= @forecast_data['list'].map do |item|
        {
          date: Time.zone.at(item['dt']).strftime('%Y-%m-%d'),
          temp: item['main']['temp']
        }
      end
    end
  end
end
