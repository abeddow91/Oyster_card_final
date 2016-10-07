require 'journey'

describe Journey do
  subject(:tube_journey) {described_class.new}
  let(:start_station) { double :start_station, :name => "Kings X", :zone => 2}
  let(:end_station) { double :end_station, :name => "Liverpool", :zone => 1}

  describe '#start' do

    it 'has an entry station when the journey is started' do
      tube_journey.start(start_station)
      expect(tube_journey.journey[:entry_station]).to eq "Kings X"
    end

    it 'has and entry zone when the journey is started' do
      tube_journey.start(start_station)
      expect(tube_journey.journey[:entry_zone]).to eq 2
    end
  end

  describe '#finish' do

    it 'has an exit station when the journey is finished' do
      tube_journey.finish(end_station)
      expect(tube_journey.journey[:exit_station]).to eq "Liverpool"
    end

    it 'has an exit zone when the journey is finished' do
      tube_journey.finish(end_station)
      expect(tube_journey.journey[:exit_zone]).to eq 1
    end
  end

  describe '#complete' do

    it 'should tell us if a journey is complete' do
      tube_journey.start(start_station)
      tube_journey.finish(end_station)
      expect(tube_journey.complete?).to be true
    end

    it 'should tell us if a journey is incomplete due to not touching in' do
      tube_journey.finish(end_station)
      expect(tube_journey.complete?).to be false
    end

    it 'should tell us if a journey is incomplete due to not touching out' do
      tube_journey.start(start_station)
      expect(tube_journey.complete?).to be false
    end
  end

  describe '#fare' do
    it 'returns the minimum fare if journey is complete' do
      tube_journey.start(start_station)
      tube_journey.finish(end_station)
      expect(tube_journey.fare).to eq tube_journey.fare
    end

    it 'returns a penalty fare when touching out without thouching in' do
      tube_journey.finish(end_station)
      expect(tube_journey.fare).to eq Journey::PENALTY_FARE
    end

    it 'returns a penalty fare when touching in without thouching out' do
      tube_journey.start(start_station)
      expect(tube_journey.fare).to eq Journey::PENALTY_FARE
    end
  end
end
