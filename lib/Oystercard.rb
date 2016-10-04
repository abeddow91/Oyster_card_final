class Oystercard

  attr_reader :balance
  MAXIMUM_LIMIT = 90

def initialize
  @balance = 0
end

def top_up(amount)
  raise "The maximum top up value of #{MAXIMUM_LIMIT} has been reached!" if @balance + amount > MAXIMUM_LIMIT
  @balance += amount
end

end
