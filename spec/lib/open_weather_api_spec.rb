# frozen_string_literal: true

RSpec.describe OpenWeatherApi, :vcr => { record: :new_episodes } do
  describe '.current_weather' do
    subject(:action) { described_class.get_weather(city, 'PR', 'BR') }

    context 'with correct city name' do
      let(:city) { 'Cascavel' }

      it do
        expect(action).to eq('')
      end
    end

    context 'when wrong city name' do
      let(:city) { 'Asdf' }
    end
  end
end
