class Oystercard
  attr_reader :balance
  BALANCE_LIMIT = 90
  def initialize
    @balance = 0
  end
  def top_up(amount)
    fail "Balance limit is #{BALANCE_LIMIT}" if @balance == 90
    @balance += amount
  end
  def deduct(amount)
    @balance -= amount
  end
end