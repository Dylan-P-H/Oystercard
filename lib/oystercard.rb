require 'journey'

class Oystercard
  attr_reader :balance, :card_state, :in_journey, :entry_station, :exit_station, :journey_log

  BALANCE_LIMIT = 90
  MINIMUM_FAIR = 1

  def initialize
    @balance = 0

    @journey_log = {}
  end

  def top_up(amount)
    fail "Balance limit is #{BALANCE_LIMIT}" if @balance == 90
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds for minimum fair" if @balance < MINIMUM_FAIR
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FAIR)
    @journey_log.store(@entry_station, @exit_station)
  end

  def in_journey?
    !!entry_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end