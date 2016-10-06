require 'station'

describe Station do
  subject(:station) {described_class.new("Kings X", 1)}
  it 'should have a station name' do
    expect(station.name).to eq "Kings X"
  end

  it 'should have a zone' do
    expect(station.zone).to eq 1
  end

  end
