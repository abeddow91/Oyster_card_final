require "oystercard"

describe Oystercard do
  subject(:card) {described_class.new}
  let(:station) {double :station}

  it "should have a balance of zero" do
    expect(card.balance).to eq 0
  end

  it 'should have an empty journey by default' do
    expect(card.journey).to be_empty
  end

  it 'have a clear journey history by default' do
    expect(card.journey_history).to be_empty
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument}

    it "should top up the card" do
      card.top_up(5)
      expect(card.balance).to eq 5
    end

    it "should raise an error if the top up limit is reached" do
      maximum = Oystercard::MAXIMUM_LIMIT
      card.top_up(maximum)
      expect {card.top_up(1)}.to raise_error("The maximum top up value of #{maximum} has been reached!")
    end

  end 

  describe '#deduct' do

    it 'should deduct the amount for the trip from balance' do
      card.top_up(15)
      card.touch_out(station)
      deducted_value = card.balance - Oystercard::MINIMUM_FARE
      expect(card.touch_out(station)).to eq deducted_value
    end
  end

  describe '#touch_in' do
    it { is_expected.to respond_to(:touch_in).with(1).argument }

    it "should check minimum balance" do
      expect {card.touch_in(station)}.to raise_error "Insufficient funds"
    end

    it "should remember entry station" do
      card.top_up(10)
      card.touch_in(station)
      expect(card.entry_station).to eq station
    end

  end

  describe '#touch_out' do
    it { is_expected.to respond_to(:touch_out).with(1).argument }
    let(:entry_station) {double :station}
    let(:exit_station) {double :station}

    it "should see if a card has touched out" do
      card.touch_out(station)
      expect(card.in_journey?).to eq false
    end

    it "should charge the card for the minimum fare" do
      card.top_up(15)
      card.touch_in(station)
      expect {card.touch_out(station)}.to change{card.balance}.by(-Oystercard::MINIMUM_FARE)
    end

    it 'stores exit station' do
      card.top_up(15)
      card.touch_in(station)
      card.touch_out(station)
      expect(card.exit_station).to eq station
    end

    it 'logs the journey history of the card' do
      card.top_up(15)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.journey_history).to include({entry_station: entry_station, exit_station: exit_station})
    end
  end

end
