require 'journey'

describe Journey do
  let(:start_station) { double :start_station, :name => "Kings X", :zone => 2}
  subject(:tube_journey) {described_class.new(start_station)}

  it 'has an entry station when started' do
    expect(tube_journey.journey[:entry_station]).to eq "Kings X"
  end

  it 'has a entry zone when started' do
    expect(tube_journey.journey[:entry_zone]).to eq 2
  end

  describe '#finsih' do
    let(:end_station) { double :end_station, :name => "Liverpool", :zone => 1}

    it 'has an exit station when the journey is finished' do
      tube_journey.finish(end_station)
      expect(tube_journey.journey[:exit_station]).to eq "Liverpool"
    end

    it 'has an exit zone when the journey is finished' do
      tube_journey.finish(end_station)
      expect(tube_journey.journey[:exit_zone]).to eq 1
    end
  end
end
