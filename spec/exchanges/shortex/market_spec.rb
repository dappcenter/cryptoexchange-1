require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Shortex::Market do
  it { expect(described_class::NAME).to eq 'shortex' }
  it { expect(described_class::API_URL).to eq 'https://api.shortex.net/api/v2' }
end
