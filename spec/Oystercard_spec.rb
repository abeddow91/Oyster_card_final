require "oystercard"
require "journey"

describe Oystercard do
  subject(:card) {described_class.new}
  let(:start_station) { double :start_station, :name => "Kings X", :zone => 2}
  let(:end_station) { double :end_station, :name => "Liverpool", :zone => 1}

  it "should have a balance of zero" do
    expect(card.balance).to eq 0
  end

  it 'should not be in use when created' do
    expect(card.journeys.current_journey.journey).to eq({:entry_station => nil, :entry_zone => nil, :exit_station => nil, :exit_zone => nil})
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument}

    it "should top up the card" do
      card.top_up(5)
      expect(card.balance).to eq 5
    end

    it "should raise an error if the top up limit is reached" do
      card.top_up(Oystercard::MAXIMUM_LIMIT)
      expect {card.top_up(1)}.to raise_error("The maximum top up value of #{Oystercard::MAXIMUM_LIMIT} has been reached!")
    end

  end


  describe '#touch_in' do
    it { is_expected.to respond_to(:touch_in).with(1).argument }

    it "should check minimum balance" do
      expect {card.touch_in(start_station)}.to raise_error "Insufficient funds"
    end

    it 'should charge penalty fare if double touch in' do
      card.top_up(10)
      card.touch_in(start_station)
      expect{card.touch_in(start_station)}.to change{card.balance}.by(-Journey::PENALTY_FARE)
    end

  end

  describe '#touch_out' do

    before do
      card.top_up(15)
      card.touch_in(start_station)
    end
    it { is_expected.to respond_to(:touch_out).with(1).argument }

    it "should charge the card the minimum fare if journey completed correctly" do
      expect {card.touch_out(end_station)}.to change{card.balance}.by(-Journey::MINIMUM_FARE)
    end

    it 'logs the journey history of the card' do
      card.touch_out(end_station)
      expect(card.journeys.journey_history[-1].journey).to include({entry_station: "Kings X", entry_zone: 2, exit_station: "Liverpool", exit_zone: 1})
    end
  end

end
