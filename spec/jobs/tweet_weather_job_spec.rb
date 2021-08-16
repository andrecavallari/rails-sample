# frozen_string_literal: true

RSpec.describe TweetWeatherJob, type: :job do
  include ActiveJob::TestHelper

  describe '#perform' do
    subject(:job) { described_class.perform_later('Cascavel', 'PR', 'BR') }

    it { expect { job }.to have_enqueued_job(described_class).once }
  end
end
