# Let's create a new Journey class, it should be responsible for starting a journey, finishing a journey,
# calculating the fare of a journey, and returning whether or not the journey is complete.

class Journey
  attr_reader :entry_station, :exit_station
  PENALTY_FARE = 1
  def initialize(entry_station: nil)
    @complete = false
    @entry_station = entry_station
  end
  def complete?
    return @complete
  end
  def fare
    return PENALTY_FARE
  end
  def finish(station=nil)
    @complete = true
    @exit_station = station
    return self
  end
end