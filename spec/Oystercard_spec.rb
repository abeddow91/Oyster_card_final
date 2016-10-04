require "Oystercard.rb"

describe Oystercard do

it "should have a balance of zero" do
  expect(subject.balance).to eq 0
end

it "should top up the card" do
  expect(subject.top_up(5)).to eq 5
end

it "should raise an error if the top up limit is reached" do
  maximum = Oystercard::MAXIMUM_LIMIT
  subject.top_up(maximum)
  expect {subject.top_up(1)}.to raise_error("The maximum top up value of #{maximum} has been reached!")
end
end
