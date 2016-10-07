require 'journey_log'
require 'journey'

describe JourneyLog do
  subject(:journey_log) { described_class.new}
  #let(:journey) {double :journey}
  let(:entry_station) {double :entry_station, name: "Kings X", zone: 2}
  let(:exit_station) {double :exit_station, name: "Liverpool", zone: 1}

  it 'creates a journey when initialized' do
    expect(journey_log.current_journey).to be_an_instance_of(Journey)
  end

  it 'have a clear journey history by default' do
    expect(journey_log.journey_history).to be_empty
  end

  describe '#start' do
    it 'should start a journey with an entry station' do
      journey_log.start(entry_station)
      expect(journey_log.current_journey.journey[:entry_station]).to eq "Kings X"
    end

    it 'should log the entry station\'s zone' do
      journey_log.start(entry_station)
      expect(journey_log.current_journey.journey[:entry_zone]).to eq 2
    end
  end

  describe '#finish' do
    before do
      journey_log.start(entry_station)
    end

    it 'should log a completed journey' do
      journey_log.finish(exit_station)
      expect(journey_log.journey_history[-1].journey).to include({entry_station: "Kings X", entry_zone: 2, exit_station: "Liverpool", exit_zone: 1})
    end
  end

  describe '#incomplete journeys' do

    it 'should not complete a journey if journey wasn\'t started' do
      journey_log.finish(exit_station)
      expect(journey_log.current_journey.journey[:exit_station]).to eq "Liverpool"
    end

    it 'should log the exit station\'s zone' do
      journey_log.finish(exit_station)
      expect(journey_log.current_journey.journey[:exit_zone]).to eq 1
    end
  end
end
