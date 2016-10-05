class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :journey, :journey_history
  MAXIMUM_LIMIT = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1
  # journey = {}

  def initialize
    @balance = 0
    @journey = {}
    @journey_history = []
  end

  def top_up(amount)
    raise "The maximum top up value of #{MAXIMUM_LIMIT} has been reached!" if @balance + amount > MAXIMUM_LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds" if @balance < MINIMUM_BALANCE
    @entry_station = station
    @journey[:entry_station] = station
  end

  def in_journey?
    @entry_station ? true : false
  end

  def touch_out(station)
    @entry_station = nil
    @exit_station = station
    @journey[:exit_station] = station
    deduct(MINIMUM_FARE)
  end

  def history
    journey_history << journey
  end

private

  def deduct(amount)
    @balance -= amount
  end

end
