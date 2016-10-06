require_relative 'journey'

class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :journey_history, :current_journey, :in_use
  MAXIMUM_LIMIT = 90
  MINIMUM_BALANCE = 1

  def initialize(balance=0)
    @balance = balance
    @journey_history = []
    @in_use = false
    @current_journey = Journey.new
  end

  def top_up(amount)
    raise "The maximum top up value of #{MAXIMUM_LIMIT} has been reached!" if @balance + amount > MAXIMUM_LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds" if @balance < MINIMUM_BALANCE
    @current_journey.start(station)
    @in_use = true
  end

  def in_journey?
    @in_use
  end

  def touch_out(station)
    @current_journey.finish(station)
    deduct(@current_journey.fare)
    @in_use = false
    history
  end


private

  def deduct(amount)
    @balance -= amount
  end

  def history
    @journey_history << @current_journey
  end

end
