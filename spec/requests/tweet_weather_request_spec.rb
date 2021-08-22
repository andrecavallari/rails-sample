# frozen_string_literal: true

RSpec.describe 'Tweet Weather Request' do
  describe 'POST /tweet_weather' do
    subject(:do_request) do
      post tweet_weather_index_path, params: {
        city: 'Cascavel',
        state: 'PR',
        country: 'BR'
      }
    end

    it 'enqueues job' do
      expect { do_request }.to have_enqueued_job(TweetWeatherJob).on_queue('default').with('Cascavel', 'PR', 'BR')
    end
  end
end
