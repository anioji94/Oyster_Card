class OysterCard
  attr_reader :balance, :limit, :entry_station

  DEFAULT_LIMIT = 90
  MIN_TRAVEL_BALANCE = 1
  MIN_FARE = 1

  def initialize
    @balance = 0
    @limit = DEFAULT_LIMIT
    @in_use = false
    @entry_station = "entry station"
  end

  def top_up(amount)
      raise "Limit of £#{:limit} exceeded: payment rejected." if @balance + amount >= @limit
      if @balance + amount < @limit then @balance += amount
      end
  end

  def deduct(amount)
      @balance -= amount
end

  def touch_in(station)
    raise "Insufficient funds" if @balance < MIN_TRAVEL_BALANCE
    @in_use = true
    @entry_station = station
  end

  def touch_out
    @in_use = false
    deduct(MIN_FARE)
  end

  def in_journey?
    @in_use
  end

end
