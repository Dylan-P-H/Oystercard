class Oystercard
  attr_reader :balance, :card_state, :in_journey, :entry_station, :exit_station, :journey_log

  BALANCE_LIMIT = 90
  MINIMUM_FAIR = 1

  def initialize
    @balance = 0
    @card_state = "DEACTIVATED"
    @in_journey = false
    @entry_station = nil
    @exit_station = nil
    @journey_log = {}
  end

  def top_up(amount)
    fail "Balance limit is #{BALANCE_LIMIT}" if @balance == 90
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds for minimum fair" if @balance < MINIMUM_FAIR
    @card_state = "ACTIVATED"
    @in_journey = true
    @entry_station = station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FAIR)
    @exit_station = exit_station
    @journey_log.store(@entry_station, @exit_station)
    @card_state = "DEACTIVED"
  end

  def in_journey?
    if @card_state == "ACTIVATED"
      return true
    else
      return false
    end
    !!entry_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end