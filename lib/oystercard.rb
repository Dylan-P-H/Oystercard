class Oystercard
  attr_reader :balance
  BALANCE_LIMIT = 90
  MINIMUM_FAIR = 1
  def initialize
    @balance = 0
    @card_state = "DEACTIVATED"
  end
  def top_up(amount)
    fail "Balance limit is #{BALANCE_LIMIT}" if @balance == 90
    @balance += amount
  end
  def deduct(amount)
    @balance -= amount
  end
  def touch_in
    fail "Insufficient funds for minimum fair" if @balance < MINIMUM_FAIR
    @card_state = "ACTIVATED"
  end
  def touch_out
    @card_state = "DEACTIVED"
  end
  def in_journey?
    if @card_state == "ACTIVATED"
      return true
    else
      return false
    end
  end
end