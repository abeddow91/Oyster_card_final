require_relative 'journey'
require_relative 'journey_log'

class Oystercard

  attr_reader :balance, :journey_history, :journeys, :in_use
  MAXIMUM_LIMIT = 90
  MINIMUM_BALANCE = 1

  def initialize(balance=0)
    @balance = balance
    @journeys = JourneyLog.new
  end

  def top_up(amount)
    raise "The maximum top up value of #{MAXIMUM_LIMIT} has been reached!" if @balance + amount > MAXIMUM_LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds" if @balance < MINIMUM_BALANCE
    deduct(Journey::PENALTY_FARE) if !@journeys.current_journey.journey[:entry_station].nil?
    @journeys.start(station)
  end

  def touch_out(station)
    @journeys.finish(station)
    deduct(@journeys.correct_fare)
    @journeys.creat_journey
  end


private

  def deduct(amount)
    @balance -= amount
  end
end
