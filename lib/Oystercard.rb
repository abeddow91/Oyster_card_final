class Oystercard

  attr_reader :balance, :entry_station
  MAXIMUM_LIMIT = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "The maximum top up value of #{MAXIMUM_LIMIT} has been reached!" if @balance + amount > MAXIMUM_LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds" if @balance < MINIMUM_BALANCE
    @entry_station = station
  end

  def in_journey?
    @entry_station ? true : false
  end

  def touch_out
    @entry_station = nil
    deduct(MINIMUM_FARE)
  end

private

  def deduct(amount)
    @balance -= amount
  end

end
