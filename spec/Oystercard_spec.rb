require "Oystercard.rb"

describe Oystercard do

it "should have a balance of zero" do
  expect(subject.balance).to eq 0
end

it "should top up the card" do
  expect(subject.top_up(5)).to eq 5
end
end
