class Oystercard

  attr_reader :balance
  MAXIMUM_LIMIT = 90

  def initialize
    @balance = 0
    @journey = false
  end

  def top_up(amount)
    raise "The maximum top up value of #{MAXIMUM_LIMIT} has been reached!" if @balance + amount > MAXIMUM_LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    raise "Insufficient funds" if @balance < 1
    @in_journey = true
  end

  def in_journey?
    @in_journey
  end

  def touch_out
    @in_journey = false
  end

end
